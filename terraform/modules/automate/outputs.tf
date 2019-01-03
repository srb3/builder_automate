output "public_ip" {
  value = "${aws_instance.a2.public_ip}"
}
