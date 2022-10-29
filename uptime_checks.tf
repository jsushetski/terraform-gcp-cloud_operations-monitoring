resource "google_monitoring_uptime_check_config" "uptime_checks" {
  provider = google

  for_each = var.uptime_checks

  display_name     = each.value.http_check == null ? "${each.value.host} TCP Check on port ${each.value.tcp_check.port}" : "${each.value.host} HTTP(S) Check"
  period           = "${each.value.period}s"
  selected_regions = each.value.selected_regions
  timeout          = "${each.value.timeout}s"

  dynamic "http_check" {
    for_each = each.value.http_check == null ? [] : [0]

    content { 
      path         = each.value.http_check.path
      port         = each.value.http_check.port
      use_ssl      = each.value.http_check.use_ssl
      validate_ssl = each.value.http_check.use_ssl ? each.value.http_check.validate_ssl : null
      mask_headers = false
      headers      = {}
    }
  }

  dynamic "tcp_check" {
    for_each = each.value.tcp_check == null ? [] : [0]

    content {
      port = each.value.tcp_check.port
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
