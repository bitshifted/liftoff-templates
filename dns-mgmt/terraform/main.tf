module "hetznerdns" {
  source = "./hetznerdns"
 
  dns_zones = [ {
  name = "astrolabs.io"
  ttl = 100
  timeouts = {
    read = "100s"
  }
  records = [ {
    name = "idp"
    type = "A"
    value = "128.140.61.161"
  } ]
}, {
    name = "barawespmdmn.net"
    # timeouts = {
      
    # }
    name_servers = [ {
      address = "128.140.61.161"
      port = 53
      timeouts = {
        create = "30m"
      }
    } ]
} ]
}