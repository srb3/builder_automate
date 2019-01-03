output "public_ip" {
  value = "${aws_instance.builder.public_ip}"
}
