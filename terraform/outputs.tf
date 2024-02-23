output "tls_flux_public_key" {
  description = "The SSH Public Key for the Flux service when reconsiling and updating the Flux configuration"
  value       = tls_private_key.flux.public_key_pem
}

output "gitops_emergency_password" {
  description = "The password for the emergency User for GitOps outside of OIDC configuration"
  value       = random_password.gitops_emergency.result
  sensitive   = true
}
