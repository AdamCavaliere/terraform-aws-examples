variable "app_name" {
  description = "Application Name"
  default     = "notSet"
}

variable "owner" {
  description = "Owner of the instances"
  default     = "notSet"
}

variable "ttl" {
  description = "Time to live"
  default     = "notSet"
}

variable "keyname" {
  description = "Key name for loggin into the instance"
}

variable "organization" {
  description = "Organization in TFE"
}

variable "workspace" {
  description = "Network Workspace"
}

variable "ssh_key" {
  description = "Key for executing remote commands"
}

variable "datadog_api_key" {
  description = "Datadog API Key"
}

variable "datadog_app_key" {
  description = "Datadog APP Key"
}
