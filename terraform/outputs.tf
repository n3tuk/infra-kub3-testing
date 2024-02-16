output "tls_flux_public_key" {
  description = "The SSH Public Key for the Flux service when reconsiling and updating the Flux configuration"
  value       = tls_private_key.flux.public_key_pem
}

output "cloudflare_account" {
  description = "The Account ID for Cloudflare"
  value       = data.cloudflare_accounts.n3tuk.id
}

output "cloudflare_accounts" {
  description = "The Account IDs for Cloudflare"
  value       = data.cloudflare_accounts.n3tuk.accounts
}
