data "aws_ami" "aws_image" {
  most_recent = "${var.most_recent}"
  filter {
    name  = "owner-id"
    values = ["${var.owner_id}"]
  }
  filter {
    name = "name"
    values = ["${var.name}"]
  }
}
