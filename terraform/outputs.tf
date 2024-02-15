output "tls_flux_public_key" {
  description = "The SSH Public Key for the Flux service when reconsiling and updating the Flux configuration"
  value       = tls_private_key.flux.public_key_pem
}
