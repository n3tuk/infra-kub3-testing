terraform {
  required_version = "~> 1.7.0"

  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "4.23.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6.0"
    }
    github = {
      source  = "integrations/github"
      version = "~> 5.45"
    }
    auth0 = {
      source  = "auth0/auth0"
      version = "~> 1.1.2"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.25.2"
    }
    flux = {
      source  = "fluxcd/flux"
      version = "~> 1.2.2"
    }
  }

  backend "gcs" {
    bucket = "n3tuk-genuine-caiman-terraform-states"
    prefix = "github/n3tuk/infra-kub3-testing"
  }
}
