#resource "google_monitoring_alert_policy" "alert_policies" {
#  provider = google
#
#  for_each = var.alert_policies
#
#  combiner = each.value.combiner == null ? var.alert_policy_defaults.combiner : each.value.combiner
#
#  display_name = each.value.display_name
#
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
#
#  # uptime check conditions
#  dynamic "conditions" {
#    for_each = each.value.uptime_checks
#    iterator = condition
#
#    content {
#      display_name = condition.value.display_name
#    }
#  }
#
#  notification_channels = each.value.notification_channels
#}
