# terraform-gcp-cloud_operations-monitoring
A Terraform module for managing the core functionality of the GCP Cloud Operations Suite.

## Required Providers
* HashiCorp Google https://registry.terraform.io/providers/hashicorp/google/4.13.0

## Required Resources
* https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/monitoring_alert_policy
* https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/monitoring_notification_channel
* https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/monitoring_uptime_check_config

## Variables

* **project**

  The name of the GCP project.

* **alert_policies**

  A map of objects representing alert policy configurations.  If display_name is not set, the map key is used as the display_name.

  * **combiner** (string) (default: "OR")

    The alert policy condition combiner.

  * **enabled** (bool)  (default: true)

    Enables the alert policy.

  * **uptime_checks** (object)

    A map of objects representing uptime check conditions.

    * **duration** (number)

      The number of seconds the uptime check must indicate an error before the condition will fire.

    * **uptime_check_name** (string)

      The name of the uptime check to add as an alert policy condition.

    * **ssl_expiry_checks** (optional list of objects)

      An optional list of objects representing SSL certificate expiry check configurations for the uptime check. If this attribute is omitted, SSL expiry checks are not performed.

      * **days_left** (number)

        The number of days before SSL certificate expiry that should trigger an alert.

  * **notification_channels** (optional list of strings)

    A list of notification channel names that should be configured for use by the alert policy.

* **notification_channels**

  A map of objects representing notification channels.

  * **channel_type** (string)

    The type of notification channel.  Valid values are "email" or "sms".

  * **display_name** (string)

    The displayed name of the notification channel.

  * **enabled** (bool)

    Enables or disables the notification channel.

  * **labels** (object)

    Labels define the communication mechanism used by the notification channel.  The labels are mutually exclusive.

    * **cell_number** (optional string)

      The cell number used to send SMS messages.  The string is of the form "+<country code><10-digit phone number>"

    * **email_address** (optional string)

      The email address used to send email messages.

* **uptime_checks**

  * **host** (string)

    The host the uptime check should be configured against.

  * **period** (optional number) (default: 60)

    The frequency that the uptime check should test the host.

  * **selected_regions** (optional list of strings) (default: ["USA"])

    A list of regions that should run the uptime check.

  * **timeout** (optional number) (default: 10)

    The timeout in seconds for the uptime check to receive a response from the target host.

  * **http_check** (optional object)

    An object that contains the configuration for an HTTP(S) uptime check.  If all default settings are desired, simply configuring `http_check = {}` is acceptable.

    * **path** (optional string) (default: "/")

      The URL path to check.

    * **port** (optional number) (default: 443)

      The TCP port to check on the host.

    * **use_ssl** (optional bool) (default: true)

      Configures the check to use HTTPS.

    * **validate_ssl** (optional bool) (default: true)

      Configures SSL valdiation when performing HTTPS checks.  Requires `use_ssl = true`.

  * **tcp_check** (optional object)

    An object that contains the configuration for a TCP check.

    * **port** (number)

      The TCP port to check. 
