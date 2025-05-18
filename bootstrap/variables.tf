variable "region" {
  type    = string
  default = "us-east-1"
}

variable "bucket_name" {
  type        = string
  description = "The name of the S3 bucket for Terraform backend state"
}
