resource "google_monitoring_uptime_check_config" "uptime_checks" {
  provider = google

  for_each = var.uptime_checks

  display_name     = each.key
  period           = "${coalesce(each.value.period, var.uptime_check_defaults.period)}s"
  selected_regions = coalesce(each.value.selected_regions, var.uptime_check_defaults.selected_regions)
  timeout          = "${coalesce(each.value.timeout, var.uptime_check_defaults.timeout)}s"

  dynamic "http_check" {
    for_each = each.value.http_check == null ? [] : [0]

    content { 
      path         = coalesce(each.value.http_check.path, var.uptime_check_defaults.http_check.path)
      port         = coalesce(each.value.http_check.port, var.uptime_check_defaults.http_check.port)
      use_ssl      = coalesce(each.value.http_check.use_ssl == null, var.uptime_check_defaults.http_check.use_ssl)
      validate_ssl = (coalesce(each.value.http_check.use_ssl, var.uptime_check_defaults.http_check.use_ssl) ? (coalesce(each.value.http_check.validate_ssl, var.uptime_check_defaults.http_check.validate_ssl) : null
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
