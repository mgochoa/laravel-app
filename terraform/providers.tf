provider "linode" {
  # Linode API token. Set via LINODE_TOKEN env var or terraform.tfvars.
  token = var.linode_token
}

provider "cloudflare" {
  # Cloudflare API token. Set via CLOUDFLARE_API_TOKEN env var or terraform.tfvars.
  api_token = var.cloudflare_api_token
}

provider "tls" {
  # No configuration needed.
}
