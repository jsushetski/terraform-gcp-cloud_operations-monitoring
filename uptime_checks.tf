resource "google_monitoring_uptime_check_config" "uptime_checks" {
  provider = google

  for_each = var.uptime_checks

  display_name     = each.key
  period           = "${each.value.period == null ? var.uptime_check_defaults.period : each.value.period}s"
  selected_regions = each.value.selected_regions == null ? var.uptime_check_defaults.selected_regions : each.value.selected_regions
  timeout          = "${each.value.timeout == null ? var.uptime_check_defaults.timeout : each.value.timeout}s"

  dynamic "http_check" {
    for_each = each.value.http_check == null ? [] : [0]

    content { 
      path         = each.value.http_check.path == null ? var.uptime_check_defaults.http_check.path : each.value.http_check.path
      port         = each.value.http_check.port == null ? var.uptime_check_defaults.http_check.port : each.value.http_check.port
      use_ssl      = each.value.http_check.use_ssl == null ? var.uptime_check_defaults.http_check.use_ssl : each.value.http_check.use_ssl
      validate_ssl = (each.value.http_check.use_ssl == null ? var.uptime_check_defaults.http_check.use_ssl : each.value.http_check.use_ssl) ? (each.value.http_check.validate_ssl == null ? var.uptime_check_defaults.http_check.validate_ssl : each.value.http_check.validate_ssl) : null
      mask_headers = false
      headers      = {}
    }
  }

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
