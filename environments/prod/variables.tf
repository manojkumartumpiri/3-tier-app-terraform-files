variable "aws_region" {
  description = "The AWS region where the resources will be created."
  type        = string
}
variable "frontend_image" {
  type = string
}

variable "backend_image" {
  type = string
}
variable "alerts_email" {
  type    = string
  default = "tumpirimanojkumar@gmail.com"
}
variable "common_tags" {
  description = "A map of tags to assign to the resources."
  type        = map(string)
}
