variable "vpcs" {
  type = set(object({
    name = string
    region = string
    ip_range = string
    description = optional(string)
  }))
}