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
