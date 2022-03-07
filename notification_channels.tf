resource "google_monitoring_notification_channel" "channel" {
  provider = google

  for_each = var.notification_channels

  display_name = "${each.value.channel_type}-${each.value.display_name}"
  enabled      = each.value.enabled
  type         = each.value.channel_type
  labels = {
    number        = each.value.cell_number
    email_address = each.value.email_address
  }
}
