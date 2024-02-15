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
}
