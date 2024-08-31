output "gateway_public_address" {
    description = "List of public IPv4 adresses for NAT gateways"
  value = [ for srv in hcloud_server.nat-gateway: srv.ipv4_address ]
}