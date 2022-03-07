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

variable "alert_policies" {
  type = map(object({
    combiner     = optional(string)
    display_name = string
    threshold_conditions = list(object({
      alignment_period     = string
      comparison           = string
      cross_series_reducer = string
      display_name         = string
      duration             = number
      filter               = string
      group_by_fields      = list(string)
      per_series_aligner   = string
      threshold_value      = number
      trigger              = object({
        count   = optional(number)
        percent = optional(number)
      })
    }))
    notification_channels = list(string)
  }))
}

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
