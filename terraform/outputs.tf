output "tls_flux_public_key" {
  description = "The SSH Public Key for the Flux service when reconsiling and updating the Flux configuration"
  value       = tls_private_key.flux.public_key_pem
}

output "cloudflare_tunnel_cname" {
  description = "The DNS CNAME to be used to point proxied traffic to to access hosted services in the Cluster"
  value       = cloudflare_record.kub3_tunnel.hostname
}
