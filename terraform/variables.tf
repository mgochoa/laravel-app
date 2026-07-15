# ─── Linode ───────────────────────────────────────────────────────────────────

variable "linode_token" {
  description = "Linode API personal access token"
  type        = string
  sensitive   = true
}

variable "linode_root_password" {
  description = "Root password for the Linode instance"
  type        = string
  sensitive   = true
}

variable "server_region" {
  description = "Linode region (e.g. us-east, us-central, us-southeast)"
  type        = string
  default     = "us-east"
}

variable "server_type" {
  description = "Linode instance plan (g6-nanode-1, g6-standard-1, etc.)"
  type        = string
  default     = "g6-standard-1"
}

variable "ssh_public_key" {
  description = "Public SSH key content for root access"
  type        = string
}

# ─── Cloudflare ───────────────────────────────────────────────────────────────

variable "cloudflare_api_token" {
  description = "Cloudflare API token with Zone:DNS, Zone:SSL perms"
  type        = string
  sensitive   = true
}

variable "cloudflare_account_id" {
  description = "Cloudflare account ID (for Origin CA cert management)"
  type        = string
}

variable "domain" {
  description = "Root domain (e.g. carocholab.com)"
  type        = string
  default     = "carocholab.com"
}

variable "prod_subdomain" {
  description = "Subdomain for production (e.g. laravel → laravel.carocholab.com)"
  type        = string
  default     = "laravel"
}

variable "dev_subdomain" {
  description = "Subdomain for dev (e.g. laravel-dev → laravel-dev.carocholab.com)"
  type        = string
  default     = "laravel-dev"
}

# ─── Tags (Linode labelling) ─────────────────────────────────────────────────

variable "tags" {
  description = "Tags applied to Linode resources"
  type        = list(string)
  default     = ["GamerTag"]
}
