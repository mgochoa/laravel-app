# ─── Production Origin CA Certificate ─────────────────────────────────────────

resource "tls_private_key" "prod_origin" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "tls_cert_request" "prod_origin" {
  private_key_pem = tls_private_key.prod_origin.private_key_pem

  subject {
    common_name = local.prod_url
  }
}

resource "cloudflare_origin_ca_certificate" "prod_origin" {
  csr                = tls_cert_request.prod_origin.cert_request_pem
  hostnames          = [local.prod_url]
  request_type       = "origin-rsa"
  requested_validity = 365 # days — rotate annually via terraform apply
}

# ─── Dev Origin CA Certificate ────────────────────────────────────────────────

resource "tls_private_key" "dev_origin" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "tls_cert_request" "dev_origin" {
  private_key_pem = tls_private_key.dev_origin.private_key_pem

  subject {
    common_name = local.dev_url
  }
}

resource "cloudflare_origin_ca_certificate" "dev_origin" {
  csr                = tls_cert_request.dev_origin.cert_request_pem
  hostnames          = [local.dev_url]
  request_type       = "origin-rsa"
  requested_validity = 365
}

# ─── Write Certificates to Local Disk ─────────────────────────────────────────
# These files are gitignored. They're used by the deploy pipeline to SCP
# certs to the server. Run `make deploy-certs` after `terraform apply`.

resource "local_file" "prod_cert" {
  content  = cloudflare_origin_ca_certificate.prod_origin.certificate
  filename = "${path.module}/.certs/${local.prod_url}.pem"

  # Tracks content hash — replaces file only when cert changes.
}

resource "local_file" "prod_key" {
  content  = tls_private_key.prod_origin.private_key_pem
  filename = "${path.module}/.certs/${local.prod_url}.key"

  # Warning: this private key is stored on disk. Ensure .certs/ is gitignored.
}

resource "local_file" "dev_cert" {
  content  = cloudflare_origin_ca_certificate.dev_origin.certificate
  filename = "${path.module}/.certs/${local.dev_url}.pem"
}

resource "local_file" "dev_key" {
  content  = tls_private_key.dev_origin.private_key_pem
  filename = "${path.module}/.certs/${local.dev_url}.key"
}
