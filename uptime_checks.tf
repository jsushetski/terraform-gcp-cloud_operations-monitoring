resource "google_monitoring_uptime_check_config" "uptime_checks" {
  provider = google

  for_each = var.uptime_checks

  display_name     = each.key
  period           = "${each.value.period}s"
  selected_regions = each.value.selected_regions == null ? var.uptime_check_defaults.selected_regions : each.value.selected_regions
  timeout          = "${each.value.timeout}s"

  #dynamic "http_check" {
  #}

  dynamic "tcp_check" {
    for_each = each.value.tcp_check == null ? [] : [0]

    content {
      port = each.value.tcp_check.tcp_port
    }
  }

  monitored_resource {
    type = "uptime_url"
    labels = {
      host       = each.value.host
      project_id = var.project
    }
  }
}
