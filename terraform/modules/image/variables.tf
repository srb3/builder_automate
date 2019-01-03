variable "most_recent" {
  description = "Should we use the most recent version of this image"
  default = true
}

variable "owner_id" {
  description = "the id of the image owner"
  type = "string"
}

variable "name" {
  description = "The name of the image"
  type = "string"
}
