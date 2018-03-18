provider "aws" {
  region = "us-east-2"
}

data "terraform_remote_state" "networkbase" {
  backend = "atlas"

  config {
    name = "${var.organization}/${var.workspace}"
  }
}

resource "aws_instance" "web" {
  ami                         = "ami-d8ae8bbd"
  instance_type               = "t2.micro"
  key_name                    = "${var.keyname}"
  subnet_id                   = "${element(data.terraform_remote_state.networkbase.public_subnets, 0)}"
  associate_public_ip_address = true
  security_groups             = ["${data.terraform_remote_state.networkbase.security_groups}"]
  count                       = 2

  tags {
    Name  = "${var.app_name}-vm${count.index}"
    Owner = "${var.owner}"
    TTL   = "${var.ttl}"
  }

  provisioner "remote-exec" {
    inline = [
      "DD_API_KEY=ff8262586b76b22895a0a4c801511078 bash -c \"$(curl -L https://raw.githubusercontent.com/DataDog/datadog-agent/master/cmd/agent/install_script.sh)\"",
    ]

    connection {
      user        = "ubuntu"
      type        = "ssh"
      private_key = "${var.ssh_key}"
      timeout     = "2m"
    }
  }
}
