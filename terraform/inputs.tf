variable "aws_region" {
  type        = "string"
  description = "The AWS region (datacenter) resources are created in."
}

variable "aws_profile" {
  type        = "string"
  description = "The profile on disk. Typically stored in your ~/.aws/config file."
}

variable "aws_key_pair_file" {
  type        = "string"
  description = "The path on disk to your private key. This key will be used to establish connectivity to resources."
}

variable "aws_key_pair_name" {
  type        = "string"
  description = "The name in AWS associated with the public key on your AWS account. Used to allow access to your private key file by placing your public key on resources."
}

variable "aws_image_user" {
  type        = "string"
  description = "The user which will connect to resources."
}

variable "tag_dept" {
  type        = "string"
  description = "X-Dept: A tag for identifying resources associated with your department."
}

variable "tag_customer" {
  type        = "string"
  description = "X-Customer: A tag for identifying resources associated with a customer."
}

variable "tag_project" {
  type        = "string"
  description = "X-Project: A tag for identifying resources associated with a project."
}

variable "tag_application" {
  type        = "string"
  description = "X-Application: A tag for identifying resources associated with your application."
}

variable "tag_contact" {
  type        = "string"
  description = "X-Contact: A tag for identifying resources associated with your contact info. Use the form: my_name (myname@example.com)"
}

variable "tag_ttl" {
  type        = "string"
  description = "X-TTL: A tag for identifying time-to-live. Set for the number of hours until an instance is automatically destroyed. Set to 0 for never kill."
}

variable "a2_heap_size" {
  type        = "string"
  description = "The size of the jvm heap for automates elasticsearch instance"
}

variable "a2_admin_password" {
  type        = "string"
  description = "The Admin password for the Automate instance"
}

variable "automate_image_owner_id" {
  type = "string"
  description = "The owner id of the automate image to user"
}

variable "automate_image_name" {
  type = "string"
  description = "The name of the automate image to user"
}

variable "builder_image_owner_id" {
  type = "string"
  description = "The owner id of the builder image to user"
}

variable "builder_image_name" {
  type = "string"
  description = "The name of the builder image to user"
}

variable "automate_dns_name" {
  type = "string"
  description = "The DNS name for the automate instance"
}

variable "builder_dns_name" {
  type = "string"
  description = "The DNS name for the builder instance"
}

variable "automate_license_path" {
  description = "The path to a local automate license"
  type = "string"
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

variable "zone_name" {
  description = "The name of the zone to assign records to"
  type = "string"
  default = "success.chef.co"
}

