variable "project" {
  type = "string"
}

variable "notfication_channels" {
  type = map(object({
    channel_type  = string
    display_name  = string
    enabled       = bool
    labels        = object({
      cell_number   = optional(string)
      email_address = optional(string)
    })
  }))
}
