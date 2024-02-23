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

# Configure the standard authentication with a custom Auth0 client (application)
# using OIDC, saving the configuration as a secret for GitOps to load
resource "auth0_client" "gitops" {
  name        = "kub3-${local.cluster}-gitops"
  description = "GitOps Dashboard for ${terraform.workspace} Kubernetes Cluster"
  logo_uri    = "https://assets.n3t.uk/flux-512x512.png"

  app_type = "regular_web"

  callbacks       = ["https://${local.cluster}.gitops.pip3.uk/oauth2/callback"]
  allowed_origins = ["https://${local.cluster}.gitops.pip3.uk"]
  web_origins     = ["https://${local.cluster}.gitops.pip3.uk"]

  custom_login_page_on = true
  cross_origin_auth    = false
  oidc_conformant      = true

  grant_types = [
    "implicit",
    "authorization_code",
    "refresh_token",
    "client_credentials",
  ]

  refresh_token {
    leeway          = 0
    token_lifetime  = 2592000
    rotation_type   = "rotating"
    expiration_type = "expiring"
  }

  jwt_configuration {
    alg = "RS256"
  }
}

resource "random_string" "gitops_client_secret" {
  length           = 63
  special          = true
  override_special = "+-="
}

resource "auth0_client_credentials" "gitops" {
  authentication_method = "client_secret_post"
  client_id             = auth0_client.gitops.id
  client_secret         = random_string.gitops_client_secret.result
}

data "auth0_connection" "google_oauth2" {
  name = "google-oauth2"
}

resource "auth0_connection_client" "gitops" {
  client_id     = auth0_client.gitops.id
  connection_id = data.auth0_connection.google_oauth2.id
}

resource "kubernetes_secret_v1" "flux_system_gitops_oidc" {
  metadata {
    name      = "oidc-auth"
    namespace = "flux-system"
  }

  type = "Opaque"

  data = {
    "clientID"     = auth0_client.gitops.client_id
    "clientSecret" = random_string.gitops_client_secret.result
    "issuerURL"    = "https://${var.auth0_domain}/"
    "redirectURL"  = "https://${local.cluster}.gitops.pip3.uk/oauth2/callback"
  }
}

# Configure the emergency backup user in case there are OIDC issues with the
# above configuration between GitOps and Auth0
resource "random_password" "gitops_emergency" {
  length  = 32
  special = true
}

resource "kubernetes_secret_v1" "flux_system_cluster_user_auth" {
  metadata {
    name      = "cluster-user-auth"
    namespace = "flux-system"
  }

  type = "Opaque"

  data = {
    "username" = "emergency"
    "password" = bcrypt(random_password.gitops_emergency.result)
  }
}
