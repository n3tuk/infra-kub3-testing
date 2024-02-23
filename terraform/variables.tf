variable "kube_config" {
  description = "The path to the kubectl configuration file which holds the credentails to access the Kubernetes cluster"
  type        = string
  default     = "/home/jonathan/.kube/config.yaml"
}

variable "cloudflare_account_id" {
  description = "The Account ID for the Cloudflare account to be used"
  type        = string
  default     = "e0d4aae3f32f077cd16bbc26f615738d"
}

variable "auth0_domain" {
  description = "The Domain of the Auth0 account to connect OIDC authention with"
  type        = string
  default     = "n3tuk.uk.auth0.com"
}
