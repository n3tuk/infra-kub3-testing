# annotations:
#   external-dns.alpha.kubernetes.io/target: <guid>.cfargotunnel.com
#   external-dns.alpha.kubernetes.io/cloudflare-proxied: "true"

# resource "random_string" "tunnel" {
#   length  = 32
#   special = false
# }

# resource "cloudflare_tunnel" "minikube" {
#   account_id = data.cloudflare_tunnel.n3tuk.id
#   name       = "n3tuk-minikub3-${random_pet.tag.id}"
#   secret     = base64encode(random_string.tunnel.id)
# }
