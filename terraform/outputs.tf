output "tls_flux_public_key" {
  description = "The SSH Public Key for the Flux service when reconsiling and updating the Flux configuration"
  value       = tls_private_key.flux.public_key_pem
}

output "gitops_admin_user_password" {
  description = "The password for the admin User for GitOps"
  value       = random_password.gitops_admin.result
  sensitive   = true
}
