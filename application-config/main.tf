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

  tags {
    Name  = "${var.app_name}"
    Owner = "${var.owner}"
    TTL   = "${var.ttl}"
  }
}
