variable "kube_config" {
  description = "The path to the kubectl configuration file which holds the credentails to access the Kubernetes cluster"
  type        = string
  default     = "/home/jonathan/.kube/config.yaml"
}

variable "kube_context" {
  description = "The name of the context in the kubectl configuration file to connect to the Kubernetes cluster"
  type        = string
  default     = "admin@minikube-01"
}

variable "cloudflare_account_id" {
  description = "The Account ID for the Cloudflare account to be used"
  type        = string
  default     = "e0d4aae3f32f077cd16bbc26f615738d"
}
