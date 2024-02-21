resource "cloudflare_api_token" "external_dns" {
  name = "kub3-${local.cluster}-external-dns"

  policy {
    permission_groups = [
      data.cloudflare_api_token_permission_groups.all.zone["DNS Write"],
    ]

    resources = {
      for zone in data.cloudflare_zone.n3tuk :
      "com.cloudflare.api.account.zone.${zone.id}" => "*"
    }
  }

  condition {
    request_ip {
      in = local.cloudflare_ip
    }
  }
}

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
    token = cloudflare_api_token.external_dns.value
  }
}
