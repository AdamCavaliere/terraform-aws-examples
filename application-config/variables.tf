variable "app_name" {
  Description = "Application Name"
  default     = "notSet"
}

variable "owner" {
  Description = "Owner of the instances"
  default     = "notSet"
}

variable "ttl" {
  Description = "Time to live"
  default     = "notSet"
}

variable "keyname" {
  Description = "Key name for loggin into the instance"
}

variable "organization" {
  Description = "Organization in TFE"
}

variable "workspace" {
  Description = "Network Workspace"
}
