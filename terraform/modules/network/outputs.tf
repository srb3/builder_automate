output "subnet_id" {
  value = "${aws_subnet.default.id}"
}
output "security_group_id" {
  value = "${aws_security_group.default.id}"
}
