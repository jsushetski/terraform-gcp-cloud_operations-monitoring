# terraform-gcp-cloud_operations-monitoring
A Terraform module for managing the core functionality of the GCP Cloud Operations Suite.

## Required Providers
* HashiCorp Google https://registry.terraform.io/providers/hashicorp/google/4.12.0

## Required Resources
* https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/monitoring_notification_channel

## Variables

* **project**

  The name of the GCP project.

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
