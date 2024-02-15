# n3t.uk mini-kub3 Configuration

This repository provides a simple Terraform configuration to allow it to build a
[`minikube`][minikube]-based Kubernetes cluster with Flux, hosted in GitHub, to
provide GitOps for standardised configuration and service deployments, and
connected with Cloudflare for DNS and ingress tunnels.

[minikube]: https://minikube.sigs.k8s.io/docs/

> [!NOTE]
> This repository was originally designed to deploy and manage minikube clusters
> locally. However, I have found that minikube and laptop batteries do not work
> well together. As such I have refactored this configuration to operate on my
> laptop but not deploy there. Instead `terraform` will deploy and manage a
> minikube cluster on a remote virtual machine hosted within my lab environment.

## Usage

The following must be set in the environment before `terraform plan` and `apply`
can be run:

```console
$ set -x GITHUB_TOKEN xxx
$ set -x CLOUDFLARE_TOKEN xxx
$ gcloud auth login
...
You are now logged in as [jon@than.io].
Your current project is [project-name-here].  You can change this setting by running:
  $ gcloud config set project PROJECT_ID
```
