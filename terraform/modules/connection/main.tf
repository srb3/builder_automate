resource "null_resource" "scp" {

  provisioner "local-exec" {
    command = "scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -i ${var.automate_key_pair_file} ${var.automate_image_user}@${var.automate_address}:${var.automate_remote_file_base}/${var.automate_fqdn}.cert ${var.local_file_base}/${var.automate_fqdn}.cert"
  }

  provisioner "local-exec" {
    command = "scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -i ${var.builder_key_pair_file} ${var.local_file_base}/${var.automate_fqdn}.cert ${var.builder_image_user}@${var.builder_address}:${var.builder_remote_file_base}/${var.automate_fqdn}.cert"
  }

  connection {
    host = "${var.builder_address}"
    type = "ssh"
    user = "${var.builder_image_user}"
    private_key = "${file("${var.builder_key_pair_file}")}"
  } 

  provisioner "remote-exec" {
    inline = [
      "cat ${var.builder_remote_file_base}/${var.automate_fqdn}.cert | sudo tee -a $(hab pkg path core/cacerts)/ssl/cert.pem >/dev/null",
      "sudo systemctl restart hab-sup"
    ]
  }
}
