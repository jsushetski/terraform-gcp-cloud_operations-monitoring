resource "google_monitoring_notification_channel" "channels" {
  provider = google

  for_each = var.notification_channels

  display_name = "${each.value.channel_type}-${each.value.display_name}"
  enabled      = each.value.enabled
  type         = each.value.channel_type
  labels = {
    number        = each.value.labels.cell_number
    email_address = each.value.labels.email_address
  }
}
