variable "region" {
  description = "aws region"
  type        = string
  default     = "us-east-1"
}

variable "ami" {
  description = "aws ami"
  type        = string
  default     = "ami-08d4ac5b634553e16"
}

variable "type" {
  description = "aws instance type"
  type        = string
  default     = "t2.micro"
}

variable "key_pair_name" {
  description = "aws key pair name"
  type        = string
}

variable "app_srv_sg_list" {
  description = "aws app instance security groups list"
  type        = list
  default     = ["app_srv_sg"]
}

variable "pkg_srv_sg_list" {
  description = "aws pkg instance security groups list"
  type        = list
  default     = ["pkg_srv_sg"]
}

variable "ssh_priv_key_file_path" {
  description = "private key file path"
  type        = string
  sensitive   = true
}

variable "ssh_user_name" {
  description = "ssh connection user name"
  type        = string
}
