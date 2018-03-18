data "template_file" "hostlist" {
  count    = 2
  template = "$${prefix}$${actualhost}!"

  vars {
    prefix     = "host:"
    actualhost = "${element(aws_instance.web.id, count.index)}"
  }
}

output "rendered" {
  value = "${join(",", data.template_file.hostlist.*.rendered)}"
}
