# n3t.uk k3s Testing Clusters Configuration

This repository provides a simple Terraform configuration to allow it to build a
[`k3s`][k3s]-based Kubernetes cluster with Flux, hosted in GitHub, to provide
GitOps for standardised configuration and service deployments, and connected
with Cloudflare for DNS and ingress tunnels.

[k3s]: https://k3s.io

> [!NOTE]
> This repository is not responsible for deploying the base configuration for
> each k3s Cluster; that is managed through the [`ansible`][ansible] repository
> instead. Once the Cluster is started and running, then this Terraform
> configuration will deploy standard `ConfigMap` and `Secret` resources, and
> bootstrap [`fluxcd`][fluxcd] on to the Cluster.

[ansible]: https://github.com/n3tuk/ansible
[fluxcd]: https://fluxcd.io

## Usage

The following must be set in the environment before `terraform plan` and `apply`
can be run:

```console
$ set -x GITHUB_TOKEN xxx
$ set -x CLOUDFLARE_TOKEN xxx
$ set -x AUTH0_API_TOKEN xxx
$ gcloud auth login
...
You are now logged in as [jon@than.io].
Your current project is [project-name-here].  You can change this setting by running:
  $ gcloud config set project PROJECT_ID
```

```console
$ flux create secret oci ghcr-auth \
    --url=ghcr.io \
    --username={github-user} \
    --password={github-pat}
► oci secret 'ghcr-auth' created in 'flux-system' namespace
```
