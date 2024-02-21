resource "cloudflare_api_token" "dns_tls" {
  name = "kub3-${local.cluster}-cert-manager"

  policy {
    permission_groups = [
      data.cloudflare_api_token_permission_groups.all.zone["DNS Write"],
      data.cloudflare_api_token_permission_groups.all.zone["SSL and Certificates Write"],
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

resource "kubernetes_namespace_v1" "certificates_system" {
  metadata {
    name = "certificates-system"
  }
}

resource "kubernetes_secret_v1" "certificates_system_cloudflare_token" {
  metadata {
    name      = "cloudflare-token"
    namespace = "certificates-system"
  }

  type = "Opaque"

  data = {
    "api-token" = cloudflare_api_token.external_dns.value
  }

  depends_on = [kubernetes_namespace_v1.certificates_system]
}
