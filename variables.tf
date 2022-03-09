variable "project" {
  type = string
}

variable "alert_policy_defaults" {
  type = object({
    combiner = string
  })
  default = {
    combiner = "OR"
  }
}

#variable "alert_policies" {
#  type = list(object({
#    combiner     = optional(string)
#    display_name = string
#    uptime_checks = list(object({
#      display_name = string
#    }))
#    notification_channels = list(string)
#  }))
#}

variable "notification_channels" {
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

variable "uptime_check_defaults" {
  type = object({
    selected_regions = list(string)
  })
  default = {
    selected_regions = ["USA"]
  }
}

variable "uptime_checks" {
  type = map(object({
    host             = string
    period           = number
    selected_regions = optional(list(string))
    timeout          = number
    http_check       = optional(object({
      path         = string
      port         = number
      use_ssl      = bool
      validate_ssl = bool
    }))
    tcp_check        = optional(object({
      tcp_port = optional(number)
    }))
  }))
}
