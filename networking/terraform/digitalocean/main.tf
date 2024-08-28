resource "digitalocean_vpc" "vpc" {
  for_each = { for vpc in var.vpcs : vpc.name => vpc }
  name = each.value.name
  region = each.value.region
  ip_range = each.value.ip_range
  description = each.value.description != null ? each.value.description : ""
}