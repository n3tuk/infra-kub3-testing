data "github_repository" "infra_kub3_testing" {
  full_name = "n3tuk/infra-kub3-testing"
}

resource "tls_private_key" "flux" {
  algorithm   = "ECDSA"
  ecdsa_curve = "P384"
}

resource "github_repository_deploy_key" "flux" {
  title      = "${local.hostname} Deployment Key for Flux"
  repository = data.github_repository.infra_kub3_testing.name
  key        = tls_private_key.flux.public_key_openssh
  read_only  = "false"
}
