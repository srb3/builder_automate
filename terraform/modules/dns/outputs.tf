output "fqdn" {
  value = "${var.name}.${var.zone_name}"
}
