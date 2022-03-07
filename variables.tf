variable "project" {
  type = "string"
}

variable "notfication_channels" {
  type = map(object({
    cell_number   = string
    channel_type  = string
    display_name  = string
    email_address = string
    enabled       = bool
  }))
}
