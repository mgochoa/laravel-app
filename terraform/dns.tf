# Look up the Cloudflare zone for the root domain.
# Requires an API token with Zone:Zone (Read) permission.
data "cloudflare_zone" "main" {
  filter = {
    name = var.domain
  }
}

# ─── Production DNS ───────────────────────────────────────────────────────────

resource "cloudflare_dns_record" "prod_a" {
  zone_id = data.cloudflare_zone.main.id
  name    = var.prod_subdomain
  content = one(linode_instance.app.ipv4)
  type    = "A"
  ttl     = 1       # 1 = Auto (Cloudflare recommends auto)
  proxied = true    # Proxied through Cloudflare (orange cloud)
  comment = "GamerTag production — managed by Terraform"
}

# ─── Dev DNS ──────────────────────────────────────────────────────────────────

resource "cloudflare_dns_record" "dev_a" {
  zone_id = data.cloudflare_zone.main.id
  name    = var.dev_subdomain
  content = one(linode_instance.app.ipv4)
  type    = "A"
  ttl     = 1
  proxied = true
  comment = "GamerTag dev — managed by Terraform"
}
