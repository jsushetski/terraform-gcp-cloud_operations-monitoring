variable "project" {
  type = string
}

variable "alert_policies" {
  type = map(object({
    combiner     = optional(string, "OR")
    display_name = optional(string)
    enabled      = optional(bool, true)
    uptime_checks = optional(map(object({
      duration          = number
      uptime_check_name = string
      ssl_expiry_checks = optional(list(object({
        days_left = number
      })))
    })))
    notification_channels = optional(list(string), [])
  }))
}

variable "notification_channels" {
  type = map(object({
    channel_type = string
    display_name = string
    enabled      = bool
    labels = object({
      cell_number   = optional(string)
      email_address = optional(string)
    })
  }))
}

variable "uptime_checks" {
  type = map(object({
    host             = string
    period           = optional(number, 60)
    selected_regions = optional(list(string), ["USA"])
    timeout          = optional(number, 10)
    http_check = optional(object({
      path         = optional(string, "/")
      port         = optional(number, 443)
      use_ssl      = optional(bool, true)
      validate_ssl = optional(bool, true)
    }))
    tcp_check = optional(object({
      port = number
    }))
  }))
}
