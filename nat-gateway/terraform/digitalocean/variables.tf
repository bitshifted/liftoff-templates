variable "do_vpcs" {
  type = set(object({
    name     = string
    ip_range = string
  }))
}

variable "do_ssh_keys" {
  type    = set(string)
  default = []
}

variable "do_gateways" {
  type = set(object({
    name          = string
    os_image      = optional(string, "ubuntu-24-04-x64")
    size = optional(string, "s-1vcpu-512mb-10gb")
    region      = string
    vpc      = string
    labels        = optional(map(string))
  }))
}