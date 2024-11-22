# NAT gateway hosts
resource "digitalocean_droplet" "nat-gateway" {
  for_each    = { for gw in var.do_gateways : gw.name => gw }
  name = each.value.name
  image = each.value.os_image
  size = each.value.size
  region = each.value.region
  ssh_keys = var.do_ssh_keys
  user_data   = file("./cloud-config.yaml")
  vpc_uuid = data.digitalocean_vpc.vpcs[each.value.vpc].id
  tags = [for key, value in each.value.tags : format("%s:%s", key, value)]
}

# project which contains resources

locals {
  natgw_ids =toset([for gw in digitalocean_droplet.nat-gateway : gw.urn])
}

resource "digitalocean_project_resources" "projects_natgws" {
  # for_each = {for idx,val in local.natgw_list: idx => val}
  project = data.digitalocean_project.project.id
  resources = local.natgw_ids
}