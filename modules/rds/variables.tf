variable "project_name" {
  description = "The name of the project."
  type        = string
}
variable "db_name" {
  description = "The name of the database."
  type        = string
}
variable "db_username" {
  type = string
}
variable "private_subnet_ids" {
  type = list(string)
}

variable "security_group_id" {
  type = string
}

variable "tags" {
  type = map(string)
}