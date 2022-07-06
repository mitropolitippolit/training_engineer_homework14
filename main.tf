resource "aws_instance" "pkg01" {
  ami             = var.ami
  instance_type   = var.type
  key_name        = var.key_pair_name
  security_groups = var.app_srv_sg_list
  tags = {
    Name  = "pkg01"
    Group = "pkg"
  }
  connection {
      host        = self.public_ip
      type        = "ssh"
      private_key = "${file(var.ssh_priv_key_file_path)}"
      user        = var.ssh_user_name
  }
  provisioner "remote-exec" { inline = ["sudo apt update && sudo apt -y install python3"] }
}

resource "aws_instance" "app01" {
  ami             = var.ami
  instance_type   = var.type
  key_name        = var.key_pair_name
  security_groups = var.app_srv_sg_list
  tags = {
    Name  = "app01"
    Group = "app"
  }
  connection {
      host        = self.public_ip
      type        = "ssh"
      private_key = "${file(var.ssh_priv_key_file_path)}"
      user        = var.ssh_user_name
  }
  provisioner "remote-exec" { inline = ["sudo apt update && sudo apt -y install python3"] }
}
