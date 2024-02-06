resource "minikube_cluster" "kub3" {
  cluster_name       = "kub3-${random_pet.tag.id}"
  kubernetes_version = "stable"

  driver = "docker"
  cni    = "cilium"

  addons = [
    "default-storageclass",
    "storage-provisioner",
  ]
}
