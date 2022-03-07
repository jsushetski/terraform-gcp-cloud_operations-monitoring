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

variable "uptime_checks" {
  type = map(object({
    host             = string
    period           = number
    selected_regions = list(string)
    tcp_port         = optional(number)
    timeout          = number
  }))
}
