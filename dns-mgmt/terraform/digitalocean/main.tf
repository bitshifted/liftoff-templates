# Digital Ocean DNS resources

resource "digitalocean_domain" "domain" {
  for_each = { for zone in var.dns_zones : zone.name => zone }
  name     = each.value.name
}

locals {
  zone_records = flatten([
    for zone_name, zone in var.dns_zones : [
      for rec_key, rec in zone.records != null ? zone.records : [] : {
        zone_id     = digitalocean_domain.domain[zone_name.name].id
        rec_name    = rec.name
        zone_record = rec
      }
    ]
    ]
  )
}

resource "digitalocean_record" "dns_record" {
  for_each = { for rec in local.zone_records : rec.rec_name => rec }
  domain   = each.value.zone_id
  name     = each.value.zone_record.name
  type     = each.value.zone_record.type
  value    = each.value.zone_record.value
  ttl      = each.value.zone_record.ttl
}