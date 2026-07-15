output "server_ip" {
  description = "Public IP of the Linode server"
  value       = one(linode_instance.app.ipv4)
}

output "server_id" {
  description = "Linode instance ID"
  value       = linode_instance.app.id
}

output "prod_url" {
  description = "Production application URL"
  value       = "https://${var.prod_subdomain}.${var.domain}"
}

output "dev_url" {
  description = "Dev application URL"
  value       = "https://${var.dev_subdomain}.${var.domain}"
}

output "cloudflare_zone_id" {
  description = "Cloudflare zone ID for DNS configuration"
  value       = data.cloudflare_zone.main.id
}

output "prod_cert_pem" {
  description = "Production Origin CA certificate PEM (sensitive)"
  value       = cloudflare_origin_ca_certificate.prod_origin.certificate
  sensitive   = true
}

output "prod_cert_key" {
  description = "Production Origin CA private key PEM (sensitive)"
  value       = tls_private_key.prod_origin.private_key_pem
  sensitive   = true
}

output "dev_cert_pem" {
  description = "Dev Origin CA certificate PEM (sensitive)"
  value       = cloudflare_origin_ca_certificate.dev_origin.certificate
  sensitive   = true
}

output "dev_cert_key" {
  description = "Dev Origin CA private key PEM (sensitive)"
  value       = tls_private_key.dev_origin.private_key_pem
  sensitive   = true
}
