terraform {
  required_version = "0.11.8"
}

provider "aws" {
  profile = "${var.aws_profile}"
  shared_credentials_file = "~/.aws/credentials"
  region = "${var.aws_region}"
}

resource "random_id" "hash" {
  byte_length = 4
}

module "network" {
  source = "modules/network"
  name = "${var.tag_customer}_${var.tag_project}_${var.tag_application}_${random_id.hash.hex}"
  dept = "${var.tag_dept}"
  customer = "${var.tag_customer}"
  project = "${var.tag_project}"
  application = "${var.tag_application}"
  contact = "${var.tag_contact}" 
}

module "automate_image" {
  source = "modules/image"
  owner_id = "${var.automate_image_owner_id}"
  name = "${var.automate_image_name}"
}

module "builder_image" {
  source = "modules/image"
  owner_id = "${var.builder_image_owner_id}"
  name = "${var.builder_image_name}"
}

module "automate" {
  source = "modules/automate"
  image_id = "${module.automate_image.id}"
  key_pair_file = "${var.aws_key_pair_file}"
  key_pair_name = "${var.aws_key_pair_name}"
  subnet_id = "${module.network.subnet_id}"
  security_group_id = "${module.network.security_group_id}"
  name = "${var.tag_customer}_${var.tag_project}_${var.tag_application}_${random_id.hash.hex}"
  dept = "${var.tag_dept}"
  customer = "${var.tag_customer}"
  project = "${var.tag_project}"
  application = "${var.tag_application}"
  contact = "${var.tag_contact}"
  license_path = "${var.automate_license_path}"
  automate_fqdn = "${var.automate_dns_name}.${var.zone_name}"
  builder_fqdn = "${var.builder_dns_name}.${var.zone_name}"
  oauth_id = "${var.oauth_id}"
  oauth_secret = "${var.oauth_secret}"
}

module "automate_dns" {
  source = "modules/dns"
  zone_name = "${var.zone_name}"
  name = "${var.automate_dns_name}"
  record = "${module.automate.public_ip}" 
}

module "builder" {
  source = "modules/builder"
  image_id = "${module.builder_image.id}"
  key_pair_file = "${var.aws_key_pair_file}"
  key_pair_name = "${var.aws_key_pair_name}"
  subnet_id = "${module.network.subnet_id}"
  security_group_id = "${module.network.security_group_id}"
  name = "${var.tag_customer}_${var.tag_project}_${var.tag_application}_${random_id.hash.hex}"
  dept = "${var.tag_dept}"
  customer = "${var.tag_customer}"
  project = "${var.tag_project}"
  application = "${var.tag_application}"
  contact = "${var.tag_contact}"
  automate_fqdn = "${var.automate_dns_name}.${var.zone_name}"
  builder_fqdn = "${var.builder_dns_name}.${var.zone_name}"
  oauth_id = "${var.oauth_id}"
  oauth_secret = "${var.oauth_secret}"

}

module "builder_dns" {
  source = "modules/dns"
  zone_name = "${var.zone_name}"
  name = "${var.builder_dns_name}"
  record = "${module.builder.public_ip}" 
}

module "connect" {
  source = "modules/connection"
  automate_key_pair_file = "${var.aws_key_pair_file}"
  automate_fqdn = "${module.automate_dns.fqdn}"
  automate_address = "${module.automate.public_ip}"
  builder_key_pair_file = "${var.aws_key_pair_file}"
  builder_fqdn = "${module.builder_dns.fqdn}"
  builder_address = "${module.builder.public_ip}"
}
