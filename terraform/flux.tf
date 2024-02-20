provider "kubernetes" {
  config_path    = var.kube_config
  config_context = terraform.workspace
}

provider "flux" {
  kubernetes = {
    config_path    = var.kube_config
    config_context = terraform.workspace
  }

  git = {
    url = "ssh://github.com/${data.github_repository.infra_kub3_testing.full_name}.git"
    ssh = {
      username    = "git"
      private_key = tls_private_key.flux.private_key_pem
    }

    author_name  = "${local.hostname} Flux"
    author_email = "flux+${local.hostname}@n3t.uk"
  }
}

resource "flux_bootstrap_git" "kub3" {
  path = "flux/clusters/kub3/${local.region}/${local.environment}/${local.cluster}"

  depends_on = [
    github_repository_deploy_key.flux
  ]
}
