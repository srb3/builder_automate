resource "aws_vpc" "default" {
  cidr_block = "10.0.0.0/16"

  tags {
    Name          = "${var.name}"
    X-Dept        = "${var.dept}"
    X-Customer    = "${var.customer}"
    X-Project     = "${var.project}"
    X-Application = "${var.application}"
    X-Contact     = "${var.contact}"
    X-TTL         = "${var.ttl}"
  }
}

resource "aws_internet_gateway" "default" {
  vpc_id = "${aws_vpc.default.id}"

  tags {
    Name          = "${var.name}"
    X-Dept        = "${var.dept}"
    X-Customer    = "${var.customer}"
    X-Project     = "${var.project}"
    X-Application = "${var.application}"
    X-Contact     = "${var.contact}"
    X-TTL         = "${var.ttl}"
  }
}

resource "aws_route" "internet_access" {
  route_table_id         = "${aws_vpc.default.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.default.id}"
}

resource "aws_subnet" "default" {
  vpc_id                  = "${aws_vpc.default.id}"
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true

  tags {
    Name          = "${var.name}"
    X-Dept        = "${var.dept}"
    X-Customer    = "${var.customer}"
    X-Project     = "${var.project}"
    X-Application = "${var.application}"
    X-Contact     = "${var.contact}"
    X-TTL         = "${var.ttl}"
  }
}

////////////////////////////////
// Firewalls

resource "aws_security_group" "default" {
  name        = "${var.application}"
  description = "${var.application}"
  vpc_id      = "${aws_vpc.default.id}"

  tags {
    Name          = "${var.name}"
    X-Dept        = "${var.dept}"
    X-Customer    = "${var.customer}"
    X-Project     = "${var.project}"
    X-Application = "${var.application}"
    X-Contact     = "${var.contact}"
    X-TTL         = "${var.ttl}"
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
