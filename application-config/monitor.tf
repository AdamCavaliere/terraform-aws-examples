data "template_file" "hostlist" {
  count    = 2
  template = "\"$${prefix}$${actualhost}\""

  vars {
    prefix     = "host:"
    actualhost = "${element(aws_instance.web.*.id, count.index)}"
  }
}

output "datadog_host_list" {
  value = "${join(",", data.template_file.hostlist.*.rendered)}"
}

provider "datadog" {
  api_key = "${var.datadog_api_key}"
  app_key = "${var.datadog_app_key}"
}

resource "datadog_monitor" "app" {
  name    = "${var.app_name} Host Monitor"
  type    = "service check"
  query   = "datadog.agent.up.over(${join(",", data.template_file.hostlist.*.rendered)}).last(2).count_by_status()"
  message = "Initial Test"

  thresholds {
    ok                = 0
    warning           = 2
    warning_recovery  = 1
    critical          = 4
    critical_recovery = 3
  }

  notify_no_data    = false
  renotify_interval = 60

  notify_audit = false
  timeout_h    = 60
  include_tags = true

  silenced {
    "*" = 0
  }
}
