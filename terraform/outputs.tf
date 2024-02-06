output "cluster_name" {
  description = "The name given to the minikube Kubernetes cluster"
  value       = minikube_cluster.kub3.cluster_name
}

output "cluster_context_hostname" {
  description = "The hostname of the minikube Kubernetes cluster deployed"
  value       = minikube_cluster.kub3.host
}

output "cluster_context_cluster_ca_certificate" {
  description = "The CA Certificate of the minikube Kubernetes cluster deployed"
  value       = minikube_cluster.kub3.cluster_ca_certificate
  sensitive   = true
}

output "cluster_context_client_certificate" {
  description = "The Client Certificate of the minikube Kubernetes cluster deployed"
  value       = minikube_cluster.kub3.client_certificate
  sensitive   = true
}

output "cluster_context_client_key" {
  description = "The Client Key of the minikube Kubernetes cluster deployed"
  value       = minikube_cluster.kub3.client_key
  sensitive   = true
}

output "tls_flux_public_key" {
  description = "The SSH Public Key for the Flux service when reconsiling and updating the Flux configuration"
  value       = tls_private_key.flux.public_key_pem
}
