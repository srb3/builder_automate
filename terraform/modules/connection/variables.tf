variable "automate_key_pair_file" {
  description = "The path to the key pair file for the chef automate instance"
  type = "string"
}

variable "automate_image_user" {
  description = "The ssh user for the automate instnace"
  type = "string"
  default = "centos"
}

variable "automate_fqdn" {
  description = "The fqdn of the automate instance"
  type = "string"
}

variable "automate_address" {
  description = "The address of the automate instance"
  type = "string"
}

variable "automate_remote_file_base" {
  description = "The location of the remote file on chef automate"
  type = "string"
  default = "/tmp/data"
}

variable "local_file_base" {
  description = "The local folder for this file"
  type = "string"
  default = "scripts"
}

variable "builder_key_pair_file" {
  description = "The path to the key pair file for the hab builder instance"
  type = "string"
}

variable "builder_image_user" {
  description = "The ssh user for the automate instnace"
  type = "string"
  default = "centos"
}

variable "builder_fqdn" {
  description = "The fqdn of the automate instance"
  type = "string"
}

variable "builder_address" {
  description = "The address of the builder instance"
  type = "string"
}

variable "builder_remote_file_base" {
  description = "The location of the remote file on chef automate"
  type = "string"
  default = "/tmp"
}
