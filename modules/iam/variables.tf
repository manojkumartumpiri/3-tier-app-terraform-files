variable "project_name" {
  type = string
}

variable "tags" {
  type = map(string)
}
variable "db_secret_arn" {
  type = string
}
variable "github_org" {
  type = string
}
variable "frontend_ecr_arn" {
  type = string
}

variable "backend_ecr_arn" {
  type = string
}
variable "github_repositories" {
  type = list(string)
}
