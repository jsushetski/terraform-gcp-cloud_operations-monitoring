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
    channel_type = string
    display_name = string
    enabled      = bool
    labels = object({
      cell_number   = optional(string)
      email_address = optional(string)
    })
  }))
}

variable "uptime_check_defaults" {
  type = object({
    period           = number
    selected_regions = list(string)
    timeout          = number
    http_check = object({
      path         = string
      port         = number
      use_ssl      = bool
      validate_ssl = bool
    })
  })
  default = {
    period           = 60
    selected_regions = ["USA"]
    timeout          = 10
    http_check = {
      path         = "/"
      port         = 443
      use_ssl      = true
      validate_ssl = true
    }
  }
}

variable "uptime_checks" {
  type = map(object({
    host             = string
    period           = optional(number)
    selected_regions = optional(list(string))
    timeout          = optional(number)
    http_check = optional(object({
      path         = optional(string)
      port         = optional(number)
      use_ssl      = optional(bool)
      validate_ssl = optional(bool)
    }))
    tcp_check = optional(object({
      tcp_port = optional(number)
    }))
  }))
}
