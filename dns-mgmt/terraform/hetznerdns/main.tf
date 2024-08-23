

resource "hetznerdns_zone" "dns_zone" {
    for_each = {for zone in var.dns_zones: zone.name => zone}
    name = each.value.name
    ttl = each.value.ttl
    dynamic "timeouts" {
      for_each = each.value.timeouts == null ? [] : each.value.timeouts[*]
      content {
         read = each.value.timeouts.read
         create = each.value.timeouts.create
         update = each.value.timeouts.update
         delete = each.value.timeouts.delete
      }
    }
   
}

locals {
  zone_name_servers = flatten([
    for zone_name, zone in var.dns_zones : [
        for server_key, server in zone.name_servers != null ? zone.name_servers : [] : {
            zone_id = hetznerdns_zone.dns_zone[zone_name.name].id
            nameserver = server
            srv_name = server.address
        }
    ]
  ]
  )
  zone_records = flatten([
    for zone_name, zone in var.dns_zones: [
      for rec_key, rec in zone.records != null ? zone.records : [] : {
        zone_id = hetznerdns_zone.dns_zone[zone_name.name].id
        rec_name = rec.name
        zone_record = rec
      }
    ]
  ]
  )
}


resource "hetznerdns_primary_server" "name_server" {
    for_each = {for ns in local.zone_name_servers: ns.srv_name => ns }
    zone_id = each.value.zone_id
    address = each.value.nameserver.address
    port = each.value.nameserver.port
    dynamic "timeouts" {
      for_each = each.value.nameserver.timeouts == null ? [] : each.value.nameserver.timeouts[*]
      content {
         read = each.value.nameserver.timeouts.read
         create = each.value.nameserver.timeouts.create
         update = each.value.nameserver.timeouts.update
         delete = each.value.nameserver.timeouts.delete
      }
    }
}

resource "hetznerdns_record" "dns_record" {
  for_each = {for rec in local.zone_records: rec.rec_name => rec }
  zone_id = each.value.zone_id
  name = each.value.zone_record.name
  type = each.value.zone_record.type
  value = each.value.zone_record.value
  ttl = each.value.zone_record.ttl
  dynamic "timeouts" {
      for_each = each.value.zone_record.timeouts == null ? [] : each.value.zone_record.timeouts[*]
      content {
         read = each.value.zone_record.timeouts.read
         create = each.value.zone_record.timeouts.create
         update = each.value.zone_record.timeouts.update
         delete = each.value.zone_record.timeouts.delete
      }
    }
}