resource "aws_instance" "a2" {
  connection {
    user        = "${var.image_user}"
    private_key = "${file("${var.key_pair_file}")}"
  }

  ami                         = "${var.image_id}"
  instance_type               = "${var.instance_size}"
  key_name                    = "${var.key_pair_name}"
  subnet_id                   = "${var.subnet_id}"
  vpc_security_group_ids      = ["${var.security_group_id}"]
  associate_public_ip_address = "${var.associate_public_ip_address}"

  root_block_device {
    delete_on_termination = "${var.delete_on_termination}"
    volume_size           = "${var.volume_size}"
    volume_type           = "${var.volume_type}"
  }

  tags {
    Name          = "${var.name}"
    X-Dept        = "${var.dept}"
    X-Customer    = "${var.customer}"
    X-Project     = "${var.project}"
    X-Application = "${var.application}"
    X-Contact     = "${var.contact}"
    X-TTL         = "${var.ttl}"
  }

  provisioner "file" {
    source      = "${var.license_path}"
    destination = "${var.license_destination_path}"
  }

  provisioner "local-exec" {
    command = "cp ${var.script_path} ${var.scirpt_tmp_path}"
  }

  provisioner "local-exec" {
    command = "sed -i 's/automate_es_heap_size/${var.heap_size}/' ${var.scirpt_tmp_path}"
  }

  provisioner "local-exec" {
    command = "sed -i 's/automate_admin_password/${var.admin_password}/' ${var.scirpt_tmp_path}"
  }

  provisioner "local-exec" {
    command = "sed -i 's/automate_fqdn/${var.automate_fqdn}/' ${var.scirpt_tmp_path}"
  }

  provisioner "local-exec" {
    command = "sed -i 's/builder_fqdn/${var.builder_fqdn}/' ${var.scirpt_tmp_path}"
  }
  provisioner "local-exec" {
    command = "sed -i 's/oauth_id/${var.oauth_id}/' ${var.scirpt_tmp_path}"
  }

  provisioner "local-exec" {
    command = "sed -i 's/oauth_secret/${var.oauth_secret}/' ${var.scirpt_tmp_path}"
  }

  provisioner "file" {
    source      = "${var.scirpt_tmp_path}"
    destination = "${var.temp_script_destination_path}"
  }

  provisioner "remote-exec" {
    inline = "sudo chmod +x ${var.temp_script_destination_path}"
  }

  provisioner "remote-exec" {
    inline = "${var.temp_script_destination_path}"
  }

  provisioner "remote-exec" {
    inline = [
      "sleep 10",
      "sudo cp -r /hab/svc/automate-load-balancer/data /tmp",
      "sudo chown -R centos:centos /tmp/data"
    ]
  }
}
