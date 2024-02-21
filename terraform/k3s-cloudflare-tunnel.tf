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
  config_src = "local"

  name   = "kub3-${local.cluster}"
  secret = base64sha256(random_password.tunnel.result)
}

resource "kubernetes_namespace_v1" "cloudflare_system" {
  metadata {
    name = "cloudflare-system"
  }
}

resource "kubernetes_secret_v1" "cloudflare_system_tunnel_credentials" {
  metadata {
    name      = "tunnel-credentials"
    namespace = kubernetes_namespace_v1.cloudflare_system.metadata[0].name
  }

  type = "Opaque"

  data = {
    "credentials.json" = jsonencode({
      AccountTag   = var.cloudflare_account_id
      TunnelSecret = base64sha256(random_password.tunnel.result)
      TunnelName   = "kub3-${local.cluster}"
      TunnelID     = cloudflare_tunnel.kub3.id
    })
  }
}

resource "kubernetes_config_map_v1" "cloudflare_system_tunnel_overrides" {
  metadata {
    name      = "tunnel-overrides"
    namespace = kubernetes_namespace_v1.cloudflare_system.metadata[0].name
  }

  data = {
    "values.yaml" = yamlencode({
      cloudflare = {
        tunnelName = cloudflare_tunnel.kub3.cname
        secretName = kubernetes_secret_v1.cloudflare_system_tunnel_credentials.metadata[0].name
      }
    })
  }
}
