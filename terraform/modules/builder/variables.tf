variable "image_user" {
  description = "The ssh user for the automate instance"
  type = "string"
  default = "centos"
}

variable "key_pair_file" {}

variable "image_id" {
  description = "The id of the image to use for the automate instance"
  type = "string"
}

variable "instance_size" {
  description = "The image size for the automate instance"
  type = "string"
  default = "t2.large"
}

variable "key_pair_name" {}

variable "subnet_id" {
  description = "The id of the subnet to place the automate instance"
  type = "string"
}

variable "security_group_id" {
  description = "The security group id for the automate instance"
  type = "string"
}

variable "associate_public_ip_address" {
  description = "Should we associate a public IP address with the automate instance"
  type = "string"
  default = "true"
}

variable "delete_on_termination" {
  description = "Should the automate instance's root disk be deleted on termination"
  type = "string"
  default = "true"
}

variable "volume_size" {
  description = "The size of the root disk"
  type = "string"
  default = "40"
}

variable "volume_type" {
  description = "The type of root disk volume"
  type = "string"
  default = "gp2"
}

variable "name" {
  description = "The name for the automate instance"
  type = "string"
}

variable "dept" {
  description = "The dept tag for the automate instance"
  type = "string"
}

variable "customer" {
  description = "The customer tag for the automate instance"
  type = "string"
}

variable "project" {
  description = "The project tag for the automate instance"
  type = "string"
}

variable "application" {
  description = "The application tag for the automate instance"
  type = "string"
}

variable "contact" {
  description = "The contact tag for the automate instance"
  type = "string"
}

variable "ttl" {
  description = "The ttl tag for the automate instance"
  default = 0
}

variable "oauth_id" {
  type = "string"
  description = "The oauth id to use"
  default = "bcbd159916107c3c858bbdc5020b115e"
}

variable "oauth_secret" {
  type = "string"
  description = "The oauth secret to use"
  default = "5c2c81cce4e5ee8dd8caaa435c492b42"
}

variable "automate_fqdn" {}
variable "builder_fqdn" {}

variable "script_path" {
  description = "The path the to setup sctipt"
  type = "string"
  default = "scripts/bldr_setup.sh"
}

variable "scirpt_tmp_path" {
  description = "The path the to setup sctipt temp file"
  type = "string"
  default = "scripts/t_bldr_setup.sh"
}

variable "temp_script_destination_path" {
  description = "The path to the remote copy of the setup script"
  type = "string"
  default = "/tmp/t_bldr_setup.sh"
}
