variable "project_name" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "frontend_service_name" {
  type = string
}

variable "backend_service_name" {
  type = string
}

variable "alb_arn_suffix" {
  type = string
}

variable "backend_target_group_arn_suffix" {
  type = string
}

variable "db_instance_id" {
  type = string
}

variable "tags" {
  type = map(string)
}
variable "alerts_email" {
  type = string
}