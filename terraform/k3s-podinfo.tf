resource "kubernetes_namespace_v1" "app_podinfo" {
  metadata {
    name = "app-podinfo"
  }
}

resource "kubernetes_config_map_v1" "app_podinfo_podinfo_overrides" {
  metadata {
    name      = "podinfo-overrides"
    namespace = kubernetes_namespace_v1.app_podinfo.metadata[0].name
  }

  data = {
    "values.yaml" = yamlencode({
      "ingress" = {
        "annotations" = {
          "external-dns.alpha.kubernetes.io/target"             = cloudflare_tunnel.kub3.cname
          "external-dns.alpha.kubernetes.io/cloudflare-proxied" = "true"
        }
      }
    })
  }
}
