output "private_subnets" {
  value = "${module.vpc.private_subnets}"
}

output "public_subnets" {
  value = "${module.vpc.public_subnets}"
}

output "vpcid" {
  value = "${module.vpc.vpc_id}"
}

output "security_groups" {
  value = "${module.security-group.this_security_group_id}"
}
