output "builder_public_ip" {
  value = "${module.builder.public_ip}"
}
output "automate_public_ip" {
  value = "${module.automate.public_ip}"
}
output "builder_fqdn" {
  value = "${module.builder_dns.fqdn}"
}
output "automate_fqdn" {
  value = "${module.automate_dns.fqdn}"
}
