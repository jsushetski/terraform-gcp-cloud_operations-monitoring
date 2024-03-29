resource "google_monitoring_alert_policy" "alert_policies" {
  provider = google

  for_each = var.alert_policies

  combiner = each.value.combiner

  display_name = coalesce(each.value.display_name, each.key)
  enabled      = each.value.enabled

#  # threshold conditions
#  dynamic "conditions" {
#    for_each = each.value.threshold_conditions
#    iterator = condition
#
#    content {
#      display_name = condition.value.display_name
#
#      condition_threshold {
#        comparison      = condition.value.comparison
#        duration        = condition.value.duration
#        filter          = condition.value.filter
#        threshold_value = condition.value.threshold_value
#
#        aggregations {
#          alignment_period     = condition.value.alignment_period
#          cross_series_reducer = condition.value.cross_series_reducer
#          group_by_fields      = condition.value.group_by_fields
#          per_series_aligner   = condition.value.per_series_aligner
#        }
#
#        trigger {
#          count   = condition.value.trigger.count
#          percent = condition.value.trigger.percent
#        }
#      }
#    }
#  }

  # uptime check conditions are a special form of threshold_condition
  dynamic "conditions" {
    for_each = each.value.uptime_checks == null ? {} : each.value.uptime_checks
    iterator = uptime_check

    content {
      display_name = uptime_check.key
      condition_threshold {
        comparison      = "COMPARISON_GT"
        duration        = "${uptime_check.value.duration}s"
        filter          = "metric.type=\"monitoring.googleapis.com/uptime_check/check_passed\" resource.type=\"uptime_url\" metric.label.\"check_id\"=\"${google_monitoring_uptime_check_config.uptime_checks[uptime_check.value.uptime_check_name].uptime_check_id}\""
        threshold_value = 1

        aggregations {
          alignment_period     = "1200s"
          cross_series_reducer = "REDUCE_COUNT_FALSE"
          group_by_fields      = ["resource.*",]
          per_series_aligner   = "ALIGN_NEXT_OLDER"
        }

        trigger {
          count = 1
        }
      }
    }
  }

  # SSL certificate expiry conditions are a special form of threshold condition
  dynamic "conditions" {
    for_each = each.value.uptime_checks == null ? [] : flatten(
      [
        for uptime_check in each.value.uptime_checks :
          [
            for ssl in uptime_check.ssl_expiry_checks :
              merge(ssl, {"uptime_check_host" = google_monitoring_uptime_check_config.uptime_checks[uptime_check.uptime_check_name].monitored_resource[0].labels.host})
          ]
          if uptime_check.ssl_expiry_checks != null
      ]
    )
    iterator = ssl_check

    content {
      display_name = "SSL Expiry Check on ${ssl_check.value.uptime_check_host} - ${ssl_check.value.days_left} days left"
      condition_threshold {
        comparison      = "COMPARISON_LT"
        duration        = "60s"
        filter          = "metric.type=\"monitoring.googleapis.com/uptime_check/time_until_ssl_cert_expires\" resource.type=\"uptime_url\" resource.label.host=\"${ssl_check.value.uptime_check_host}\""
        threshold_value = ssl_check.value.days_left

        aggregations {
          alignment_period     = "300s"
          cross_series_reducer = "REDUCE_MAX"
          group_by_fields      = []
          per_series_aligner   = "ALIGN_MEAN"
        }

        trigger {
          count = 1
        }
      }
    }
  }

  notification_channels = [for channel in each.value.notification_channels : google_monitoring_notification_channel.channels[channel].id]
}
