data "cloudflare_api_token_permission_groups" "all" {}

data "cloudflare_accounts" "n3tuk" {
  name = "n3tuk"
}

data "cloudflare_zone" "n3tuk" {
  for_each = toset(local.cloudflare_domains)
  name     = each.value
}
