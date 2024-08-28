variable "networks" {
  type = set(object({
    name                     = string
    ip_range                 = string
    delete_protection        = optional(bool)
    expose_routes_to_vswitch = optional(bool)
    subnets = optional(set(object({
      type       = string
      region     = string
      ip_range   = string
      vswitch_id = optional(string)
    })))
  }))
}