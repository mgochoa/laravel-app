# GamerTag

A Laravel 13 application — visit at **[https://laravel.carocholab.com](https://laravel.carocholab.com)**

## Design

Design decisions and frontend conventions live in `DESIGN.md`.

## Deployment

### Infrastructure

| Component | Detail |
|-----------|--------|
| Server | Linode (Akamai) — Ubuntu 24.04 |
| Web server | Nginx 1.24 + PHP 8.4-FPM |
| Database | SQLite |
| Domain | `laravel.carocholab.com` via Cloudflare (proxied) |
| SSL | Cloudflare Origin CA certificate on Nginx |
| CI/CD | GitHub Actions → RSync + SSH |

### GitHub Secrets

Set these in **Settings → Secrets and variables → Actions**:

| Secret | Description |
|--------|-------------|
| `DEPLOY_HOST` | Server IP (`172.235.136.90`) |
| `DEPLOY_USER` | SSH user (`root`) |
| `DEPLOY_SSH_KEY` | Contents of the private SSH key |

### Provisioning a new server

Run on a fresh Ubuntu 24.04 Linode:

```bash
scp deploy/provision-server.sh root@<NEW-IP>:~
ssh root@<NEW-IP> ./provision-server.sh laravel.carocholab.com
```

This installs Nginx, PHP 8.4, Composer, Node.js, and creates the Nginx config.

Then upload the SSL certificates:

```bash
scp laravel.carocholab.com.pem root@<NEW-IP>:/etc/nginx/ssl/
scp laravel.carocholab.com.key root@<NEW-IP>:/etc/nginx/ssl/
```

Point `DEPLOY_HOST` to the new IP and push to deploy.

### SSH access

```bash
make ssh
```

Requires `DEPLOY_HOST`, `DEPLOY_USER`, `DEPLOY_SSH_KEY` in `.env`.

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

### Files

| File | Purpose |
|------|---------|
| `deploy/nginx.conf` | Production Nginx config |
| `deploy/nginx-dev.conf` | Dev Nginx config |
| `deploy/provision-server.sh` | Full server setup from bare OS (run once) |
| `deploy/provision.sh` | Post-deploy tasks (permissions, caches) |
| `.github/workflows/deploy.yml` | Production CI/CD (master branch) |
| `.github/workflows/deploy-dev.yml` | Dev CI/CD (dev branch) |
