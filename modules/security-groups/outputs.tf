output "alb_security_group_id" {
  value = aws_security_group.alb_sg.id
}

output "frontend_security_group_id" {
  value = aws_security_group.web_sg.id
}

output "backend_security_group_id" {
  value = aws_security_group.backend_sg.id
}

output "rds_security_group_id" {
  value = aws_security_group.db_sg.id
}