variable "domain_name" {
  type = string
}

variable "subject_alternative_names" {
  type    = list(string)
  default = []
}

variable "tags" {
  type = map(string)
}
variable "validation_method" {
  description = "Method to validate the ACM certificate."
  type        = string
  default     = "DNS"
}