# NAT gateway hosts
resource "digitalocean_droplet" "nat-gateway" {
  for_each    = { for gw in var.do_gateways : gw.name => gw }
  name = each.value.name
  image = each.value.os_image
  size = each.value.size
  region = each.value.region
  ssh_keys = var.do_ssh_keys
  vpc_uuid = data.digitalocean_vpc.vpcs[each.value.vpc].id
    
  }