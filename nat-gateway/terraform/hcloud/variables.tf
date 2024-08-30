variable "private_networks" {
  type = set(object({
    name = string
    ip_range = string
  }))
}

variable "gateways" {
  type = set(object({
    name = string
    os_image = optional(string, "ubuntu-24.04")
    instance_type = optional(string, "cx22")
    location = string
    networks = set(string)
    labels = optional(map(string))
  }))
}