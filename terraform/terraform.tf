terraform {
  required_version = "~> 1.7.0"

  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6.0"
    }
    minikube = {
      source  = "scott-the-programmer/minikube"
      version = "~> 0.3.9"
    }
    github = {
      source  = "integrations/github"
      version = "~> 5.45"
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
    prefix = "github/n3tuk/infra-minikub3"
  }
}

provider "google" {
  project = "genuine-caiman"
  region  = "europe-west2"
  zone    = "europe-west2-a"

  default_labels = {
    environment = "development"
    deployer    = "terraform"
    owner       = "jonathan-wright"
  }
}

provider "github" {
  owner = "n3tuk"
}
