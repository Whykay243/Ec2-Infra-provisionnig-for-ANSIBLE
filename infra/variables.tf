variable "region" {
  default = "us-east-2"
}

variable "key_name" {
  description = "Name for the EC2 key pair"
}

variable "instance1" {
  default = "t2.micro"
}

variable "instance2" {
  default = "t2.small"
}
