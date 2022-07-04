resource "aws_key_pair" "custom_keypair" {
  key_name   = "custom_keypair"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC8tEjYpU9utaKC15qdgDyixBiKqEyBa+UZ+uu/pJTsci9+YOUYvht37zfdgLZKPyqUB02GEE4v8JxoVPgBCP60/r5uVG5BAMCUIOLcvT0zaqS/ZdlcjIFFPQ6teHgWANfg+uniWBzdIifvYeavEIyWuGa6C1beeyJJO9pHksBdlYRCniLaYvMXk6fQ0qdw+TvL8Y2wlsZKbEDjsFeTj8HwzgYRKdlXbI0xQFcd5r18ZxwdWt13ZcrzNuVFG7r8t39K/jO2+kddoyfngXT+AnYoUCR3Q1ZuY5UzvsZTG687NTHQ4GubLs0PCxuqWGyPai1yBU4UFSZKY+1VnuEkjT9mtdU62Hp33r3Gom5ASKHYqL5SZgJJgO+pLEIVU4Y58AZt7xLAIxlogzHfTfYpu7BkufHLpNFy20TOEholueY8BH1RRs14SRp27Xo41cWS6W/+wVg29HSuvEJUXkKO1l9mYHUC71BGZhtqRWkozO/aYw+RR4JWjbWUaa4RGOryNf0="
}

resource "aws_security_group" "http" {
  name        = "http"
  description = "allow http in"
  ingress {
    description      = "http alt"
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  tags = {
    Name = "http"
  }
}

resource "aws_security_group" "ssh" {
  name        = "ssh"
  description = "allow ssh in"
  ingress {
    description      = "ssh"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  tags = {
    Name = "ssh"
  }
}

resource "aws_instance" "pkg01" {
  ami = var.ami
  instance_type = var.type
  key_name = aws_key_pair.custom_keypair.key_name
  security_groups = [aws_security_group.ssh.name]
  tags = {
    Name = "pkg01"
  }
}

resource "aws_instance" "app01" {
  ami = var.ami
  instance_type = var.type
  key_name = aws_key_pair.custom_keypair.key_name
  security_groups = [aws_security_group.ssh.name,aws_security_group.http.name]
  tags = {
    Name = "app01"
  }
}

output "app01_public_ip" {
  value = aws_instance.app01.public_ip
}

output "pkg01_public_ip" {
  value = aws_instance.pkg01.public_ip
}
