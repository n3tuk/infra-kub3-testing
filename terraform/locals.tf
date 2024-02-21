locals {
  hostname    = terraform.workspace
  cluster     = element(split(".", terraform.workspace), 0)
  environment = lookup(local.environment_names, element(split(".", terraform.workspace), 1), "unknown")
  region      = element(split(".", terraform.workspace), 2)

  environment_names = {
    p = "production"
    d = "development"
    t = "testing"
    s = "services"
  }

  cloudflare_domains = [
    "kub3.uk",
    "pip3.uk",
    "sit3.uk",
    "liv3.uk",
    "t3st.uk",
  ]

  cloudflare_ip = [
    "82.69.106.64/32",
    "2a02:8010:8006::/48",
  ]
}
