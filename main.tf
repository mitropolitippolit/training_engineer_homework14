resource "aws_key_pair" "custom_keypair" {
  key_name   = "custom_keypair"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC8tEjYpU9utaKC15qdgDyixBiKqEyBa+UZ+uu/pJTsci9+YOUYvht37zfdgLZKPyqUB02GEE4v8JxoVPgBCP60/r5uVG5BAMCUIOLcvT0zaqS/ZdlcjIFFPQ6teHgWANfg+uniWBzdIifvYeavEIyWuGa6C1beeyJJO9pHksBdlYRCniLaYvMXk6fQ0qdw+TvL8Y2wlsZKbEDjsFeTj8HwzgYRKdlXbI0xQFcd5r18ZxwdWt13ZcrzNuVFG7r8t39K/jO2+kddoyfngXT+AnYoUCR3Q1ZuY5UzvsZTG687NTHQ4GubLs0PCxuqWGyPai1yBU4UFSZKY+1VnuEkjT9mtdU62Hp33r3Gom5ASKHYqL5SZgJJgO+pLEIVU4Y58AZt7xLAIxlogzHfTfYpu7BkufHLpNFy20TOEholueY8BH1RRs14SRp27Xo41cWS6W/+wVg29HSuvEJUXkKO1l9mYHUC71BGZhtqRWkozO/aYw+RR4JWjbWUaa4RGOryNf0="
}

resource "aws_security_group" "app_sg" {
  name        = "app_sg"
  description = "allow ssh,http in"
  ingress {
    description      = "ssh"
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  ingress {
    description      = "http alt"
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  tags = {
    Name = "app_sg"
  }
}

resource "aws_security_group" "pkg_sg" {
  name        = "pkg_sg"
  description = "allow ssh in"
  ingress {
    description      = "ssh"
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  tags = {
    Name = "pkg_sg"
  }
}

resource "aws_instance" "pkg01" {
  ami = var.ami
  instance_type = var.type
  key_name = aws_key_pair.custom_keypair.key_name
  security_groups = aws_security_group.pkg_sg.name
  tags = {
    Name = "pkg01"
  }
}

resource "aws_instance" "app01" {
  ami = var.ami
  instance_type = var.type
  key_name = aws_key_pair.custom_keypair.key_name
  security_groups = aws_security_group.app_sg.name
  tags = {
    Name = "app01"
  }
}
