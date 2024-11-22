
data "digitalocean_vpc" "vpcs" {
  for_each = { for vpc in var.do_vpcs : vpc.name => vpc }
  name     = each.value.name
}

data "digitalocean_project" "project" {
  name = var.do_project_name
}
