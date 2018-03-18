#provider "datadog" {
#  api_key = "${var.datadog_api_key}"
#  app_key = "${var.datadog_app_key}"
#}

#resource "datadog_monitor" "app" {
#    name = "${var.app_name} Host Monitor"
#    type = "service check"
#    query = "datadog.agent.up.over(\"*\",\"host:i-0e55183668a1d124f\").last(2).count_by_status()"
#}

data "template_file" "hostlist" {
  template = "$${prefix}$${actualhost}!"

  vars {
    prefix     = "host:"
    actualhost = "${aws_instance.web.*.id}"
  }
}

output "rendered" {
  value = "${join(",", data.template_file.hostlist.rendered)}"
}
