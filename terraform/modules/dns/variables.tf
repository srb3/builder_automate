variable "zone_name" {
  description = "The name of the zone to assign records to"
  type = "string"
  default = "success.chef.co."
}

variable "name" {
  description = "The name of the record to add"
  type = "string"
}

variable "record" {
  description = "The address of the record to add"
  type = "string"
}

variable "type" {
  description = "The type of record to add"
  type = "string"
  default = "A"
}

variable "ttl" {
  description = "The ttl for this record"
  type = "string"
  default = "300"
}

variable "instance_size" {
  description = "The image size for the automate instance"
  type = "string"
  default = "t2.large"
}

