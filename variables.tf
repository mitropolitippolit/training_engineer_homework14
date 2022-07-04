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
  type = string
  default = "t2.micro"
}

