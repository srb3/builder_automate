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
