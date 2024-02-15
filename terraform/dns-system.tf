resource "kubernetes_namespace_v1" "dns_system" {
  metadata {
    name = "dns-system"
  }
}

resource "kubernetes_secret_v1" "dns_system_cloudflare_token" {
  metadata {
    name      = "cloudflare-token"
    namespace = "dns-system"
  }

  type = "Opaque"

  data = {
    token = cloudflare_api_token.dns.value
  }
}
