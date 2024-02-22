resource "random_password" "gitops_admin" {
  length  = 32
  special = true
}

resource "kubernetes_config_map_v1" "flux_system_gitops_ingress" {
  metadata {
    name      = "gitops-ingress"
    namespace = "flux-system"
  }

  data = {
    "values.yaml" = yamlencode({
      "ingress" = {
        "annotations" : {
          "external-dns.alpha.kubernetes.io/hostname" : "${local.cluster}.gitops.pip3.uk"
        }
        "hosts" = [{
          "host" = "${local.cluster}.gitops.pip3.uk"
          "paths" = [{
            "path"     = "/"
            "pathType" = "ImplementationSpecific"
          }]
        }]
        "tls" = [{
          "secretName" = "ingress-gitops-tls"
          "hosts"      = ["${local.cluster}.gitops.pip3.uk"]
        }]
      }
    })
  }
}

resource "kubernetes_secret_v1" "flux_system_cluster_user_auth" {
  metadata {
    name      = "cluster-user-auth"
    namespace = "flux-system"
  }

  type = "Opaque"

  data = {
    "username"     = "jonathanio"
    "passwordHash" = random_password.gitops_admin.result
  }
}
