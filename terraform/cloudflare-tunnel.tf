# annotations:
#   external-dns.alpha.kubernetes.io/target: <guid>.cfargotunnel.com
#   external-dns.alpha.kubernetes.io/cloudflare-proxied: "true"

resource "random_password" "tunnel" {
  length = 64
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
