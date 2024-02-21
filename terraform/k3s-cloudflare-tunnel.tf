resource "random_password" "tunnel" {
  length = 64
}

resource "random_pet" "tunnel" {
  length = 2
}

# Create and configure a tunnel in Cloudflare specific for this Kubernetes
# Cluster, and then configure the namespace and additional configuration
# directly into the Cluster

resource "cloudflare_tunnel" "kub3" {
  account_id = var.cloudflare_account_id
  config_src = "cloudflare"

  name   = "kub3-${local.cluster}"
  secret = base64sha256(random_password.tunnel.result)
}

resource "cloudflare_record" "kub3_tunnel" {
  zone_id = data.cloudflare_zone.n3tuk["kub3.uk"].zone_id
  name    = "${random_pet.tunnel.id}.tunnel"
  comment = "Cloudflare Tunnel DNS alias for ${terraform.workspace}"

  type  = "CNAME"
  value = cloudflare_tunnel.kub3.cname
}

resource "kubernetes_namespace_v1" "cloudflare_system" {
  metadata {
    name = "cloudflare-system"
  }
}

resource "kubernetes_secret_v1" "cloudflare_system_cloudflare_credentials" {
  metadata {
    name      = "cloudflared-credentials"
    namespace = "cloudflare-system"
  }

  type = "Opaque"

  data = {
    "credentials.json" = jsonencode({
      AccountTag   = var.cloudflare_account_id
      TunnelSecret = base64sha256(random_password.tunnel.result)
      TunnelName   = "n3tuk-${local.cluster}"
      TunnelID     = cloudflare_tunnel.kub3.id
    })
  }
}
