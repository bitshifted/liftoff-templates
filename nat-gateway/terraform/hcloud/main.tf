# NAT gateway hosts
resource "hcloud_server" "nat-gateway" {
  for_each = { for gw in var.gateways : gw.name => gw }
  name = each.value.name
  image = each.value.os_image
  server_type = each.value.instance_type
  location = each.value.location
  user_data = "${file("./cloud-config.yaml")}"
  public_net {
    ipv4_enabled = true
    ipv6_enabled = true
  }
  dynamic "network" {
    for_each = each.value.networks
    content {
        network_id = data.hcloud_network.networks[network.value].id
    }
  }
  labels = each.value.labels
}

locals {
    ip_address_net_id_map = flatten([
       for gw in var.gateways : [
        for net in hcloud_server.nat-gateway[gw.name].network : {
            net_id = net.network_id
            ip = net.ip
            key = "${gw.name}:${net.network_id}"
        }
       ]
    ])
}

# route to gateway
resource "hcloud_network_route" "nat_route" {
  for_each = {for ipmap in local.ip_address_net_id_map : ipmap.key => ipmap } 
  network_id = each.value.net_id
  destination = "0.0.0.0/0"
  gateway = each.value.ip
}