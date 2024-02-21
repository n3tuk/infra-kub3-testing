provider "github" {
  owner = "n3tuk"
}

data "github_repository" "infra_kub3_testing" {
  full_name = "n3tuk/infra-kub3-testing"
}
