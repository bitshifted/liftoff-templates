# variables

variable "dns_zones" {
  type = set(object({
    name = string
    ip_address = optional(string)
    records = optional(set(object({
      name = string
      type = string
      value = string
      port = optional(number)
      priority = optional(number)
      weight = optional(number)
      ttl = optional(number)
      flags = optional(number)
      tag = optional(string)
    })))
  }
  ))
}