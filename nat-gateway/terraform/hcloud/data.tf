
data "hcloud_network" "networks" {
  for_each = { for pn in var.hcloud_private_networks : pn.name => pn }
  name     = each.value.name
}