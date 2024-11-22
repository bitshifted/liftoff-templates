
# output "nat_gw_data" {
#   value = {
#     # for gw_key, gw in hcloud_server.nat-gateway :
#     # gw.ipv4_address => data.hcloud_network.networks[gw.network[0].network_id].ip_range
#     for gw_key, gw in hcloud_server.nat-gateway :
#     # Extract public IP address
#     flatten([for pn in gw : pn.ipv4_address]) => [  
#       # For each network associated with the gateway, get the IP range
#       for net in gw.network : data.hcloud_network.networks[net.network_id].ip_range
#     ]
#   }
# }

output "nat_gw_mapping" {
  value = { for gw in var.hcloud_gateways : 
    hcloud_server.nat-gateway[gw.name].ipv4_address => [ for gwnet in gw.networks : data.hcloud_network.networks[gwnet].ip_range ]
  } 
}


output "gateway_public_address" {
  description = "List of public IPv4 adresses for NAT gateways"
  value       = [for srv in hcloud_server.nat-gateway : srv.ipv4_address]
}