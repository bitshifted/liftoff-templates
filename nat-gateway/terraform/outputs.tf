# Combine output of all modules (merge function)
output "nat_gw_ips" {
  value = module.hcloud.gateway_public_address
}