data "github_repository" "infra_minikub3" {
  full_name = "n3tuk/infra-minikub3"
}

resource "tls_private_key" "flux" {
  algorithm   = "ECDSA"
  ecdsa_curve = "P384"
}

resource "github_repository_deploy_key" "flux" {
  title      = "A deployment key for Flux running on minikube kub3-${random_pet.tag.id}"
  repository = data.github_repository.infra_minikub3.name
  key        = tls_private_key.flux.public_key_openssh
  read_only  = "false"
}
