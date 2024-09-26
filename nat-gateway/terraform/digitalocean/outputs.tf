output "gateway_public_address" {
  description = "List of public IPv4 adresses for NAT gateways"
  value       = [for srv in digitalocean_droplet.nat-gateway : srv.ipv4_address]
}