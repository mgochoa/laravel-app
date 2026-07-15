locals {
  prod_url = "${var.prod_subdomain}.${var.domain}"
  dev_url  = "${var.dev_subdomain}.${var.domain}"
}

# ─── Linode Instance ─────────────────────────────────────────────────────────

resource "linode_instance" "app" {
  label  = "gamertag-app"
  region = "us-mia"
  type   = "g6-nanode-1"
  tags   = var.tags

  alerts {
    cpu            = 90
    io             = 10000
    network_in     = 10
    network_out    = 10
    transfer_quota = 80
  }
}

# ─── Firewall ─────────────────────────────────────────────────────────────────

resource "linode_firewall" "app" {
  label = "gamertag-app"
  tags  = var.tags

  inbound_policy = "DROP"

  inbound {
    label    = "http"
    action   = "ACCEPT"
    protocol = "TCP"
    ports    = "80"
    ipv4     = ["0.0.0.0/0"]
    ipv6     = ["::/0"]
  }

  inbound {
    label    = "https"
    action   = "ACCEPT"
    protocol = "TCP"
    ports    = "443"
    ipv4     = ["0.0.0.0/0"]
    ipv6     = ["::/0"]
  }

  inbound {
    label    = "ssh"
    action   = "ACCEPT"
    protocol = "TCP"
    ports    = "22"
    ipv4     = ["0.0.0.0/0"]
    ipv6     = ["::/0"]
  }

  outbound_policy = "ACCEPT"
}

resource "linode_firewall_device" "app" {
  firewall_id = linode_firewall.app.id
  entity_id   = 597461
  entity_type = "linode_interface"
}

# ─── SSH Key (Linode Metadata) ────────────────────────────────────────────────

resource "linode_sshkey" "deploy" {
  label   = "gamertag-deploy"
  ssh_key = var.ssh_public_key
}
