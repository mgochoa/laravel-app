# GamerTag

A Laravel 13 application — visit at **[https://laravel.carocholab.com](https://laravel.carocholab.com)**

## Design

Design decisions and frontend conventions live in `DESIGN.md`.

## Infrastructure (Terraform)

All infrastructure is managed as code via **Terraform** (`terraform/`).

| Component | Detail |
|-----------|--------|
| Compute | Linode (Akamai) — Ubuntu 24.04 (`g6-nanode-1`, Miami) |
| Web server | Nginx 1.24 + PHP 8.4-FPM |
| Database | SQLite |
| DNS | Cloudflare (proxied) — `laravel.carocholab.com` + `laravel-dev.carocholab.com` |
| SSL | Cloudflare Origin CA certificates (auto-renewed, 365-day validity) |
| Firewall | Linode Cloud Firewall (ports 22/80/443 only, DROP by default) |
| CI/CD | GitHub Actions → RSync + SSH |

### Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/install) ≥ 1.6
- Linode API token: https://cloud.linode.com/profile/tokens
- Cloudflare API token with `Zone:DNS (Edit)`, `Zone:SSL (Edit)`, `Zone:Zone (Read)` permissions

### Terraform workflow

```bash
# Initialize providers
make terraform-init

# Preview changes
make terraform-plan

# Apply infrastructure changes
make terraform-apply

# Upload generated SSL certificates to the server
make deploy-certs
```

The following is managed by Terraform:

| Resource | Description |
|---|---|
| `linode_instance.app` | The VM (`gamertag-app`, Miami, `g6-nanode-1`) |
| `linode_firewall.app` | Firewall blocking all ports except 22, 80, 443 |
| `linode_sshkey.deploy` | SSH key registered at Linode |
| `cloudflare_dns_record.prod_a` | `laravel.carocholab.com` → server IP (proxied) |
| `cloudflare_dns_record.dev_a` | `laravel-dev.carocholab.com` → server IP (proxied) |
| `cloudflare_origin_ca_certificate.*` | Origin CA certs for both domains (365-day rotation) |
| `tls_private_key.*` + `tls_cert_request.*` | Key pairs used to request Origin CA certs |
| `local_file.*` | Cert PEMs written to `terraform/.certs/` |

After `terraform apply`, run `make deploy-certs` to SCP the new certs to the server and reload Nginx.

> **Note**: Terraform state is stored locally in `terraform/terraform.tfstate`. Keep a backup.

## Deploy (application code)

### GitHub Secrets

Set these in **Settings → Secrets and variables → Actions**:

| Secret | Description |
|--------|-------------|
| `DEPLOY_HOST` | Server IP (`172.235.136.90`) |
| `DEPLOY_USER` | SSH user (`root`) |
| `DEPLOY_SSH_KEY` | Contents of the private SSH key |

### Deploy pipelines

| Branch | Environment | URL | Directory |
|--------|------------|-----|-----------|
| `master` | Production | `https://laravel.carocholab.com` | `/var/www/example-app` |
| `dev` | Development | `https://laravel-dev.carocholab.com` | `/var/www/example-app-dev` |

On every push, GitHub Actions will:
1. Install PHP deps & build frontend assets
2. RSync the code to the respective directory
3. Apply Nginx config from `deploy/`
4. Fix storage permissions
5. Run `migrate`, caches, etc.
6. Bring the site back up

### SSH access

```bash
make ssh
```

Requires `DEPLOY_HOST`, `DEPLOY_USER`, `DEPLOY_SSH_KEY` in `.env`.

## Provisioning a brand-new server

If the Linode ever needs to be rebuilt from scratch:

1. Update `terraform/terraform.tfvars` with your API tokens
2. Run `make terraform-apply` — this creates the Linode with cloud-init that installs Nginx, PHP 8.4, Composer, and Node.js
3. Run `make deploy-certs` — uploads Origin CA certificates
4. Push to `master` or `dev` — GitHub Actions deploys the app

## Files

| File | Purpose |
|------|---------|
| `terraform/` | Infrastructure as Code (Linode, Cloudflare DNS, Origin CA certs) |
| `deploy/nginx.conf` | Production Nginx config |
| `deploy/nginx-dev.conf` | Dev Nginx config |
| `deploy/provision-server.sh` | Legacy server bootstrap (replaced by Terraform cloud-init) |
| `deploy/provision.sh` | Post-deploy tasks (permissions, caches) |
| `.github/workflows/deploy.yml` | Production CI/CD (master branch) |
| `.github/workflows/deploy-dev.yml` | Dev CI/CD (dev branch) |
| `Makefile` | Shortcuts: `make ssh`, `make terraform-*`, `make deploy-certs` |
