# variables

variable "dns_zones" {
  type = set(object({
    name = string
    ttl  = optional(number)
    timeouts = optional(object({
      create = optional(string)
      read   = optional(string)
      update = optional(string)
      delete = optional(string)
    }))
    primary_servers = optional(set(object({
      address = string
      port    = number
      timeouts = optional(object({
        create = optional(string)
        read   = optional(string)
        update = optional(string)
        delete = optional(string)
      }))
    })))
    records = optional(set(object({
      name  = string
      type  = string
      value = string
      ttl   = optional(number)
      timeouts = optional(object({
        create = optional(string)
        read   = optional(string)
        update = optional(string)
        delete = optional(string)
      }))
    })))
    }
  ))
}