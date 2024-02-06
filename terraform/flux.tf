provider "kubernetes" {
  host = minikube_cluster.kub3.host

  client_certificate     = minikube_cluster.kub3.client_certificate
  client_key             = minikube_cluster.kub3.client_key
  cluster_ca_certificate = minikube_cluster.kub3.cluster_ca_certificate
}

provider "flux" {
  kubernetes = {
    host = minikube_cluster.kub3.host

    client_certificate     = minikube_cluster.kub3.client_certificate
    client_key             = minikube_cluster.kub3.client_key
    cluster_ca_certificate = minikube_cluster.kub3.cluster_ca_certificate
  }

  git = {
    url = "ssh://git@github.com/n3tuk/infra-minikube.git"
    ssh = {
      username    = "git"
      private_key = tls_private_key.flux.private_key_pem
    }

    author_name  = "n3t.uk Flux"
    author_email = "flux+kub3-${random_pet.tag.id}@n3t.uk"
  }
}

resource "flux_bootstrap_git" "this" {
  path = "flux/clusters/kub3-${random_pet.tag.id}"

  depends_on = [
    github_repository_deploy_key.flux
  ]
}
