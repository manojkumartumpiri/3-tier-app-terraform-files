# output "alb_arn_suffix" {
#   value = aws_alb.this.arn_suffix
# }

# output "backend_target_group_arn_suffix" {
#   value = aws_lb_target_group.backend.arn_suffix
# }
output "dashboard_name" {
  value = aws_cloudwatch_dashboard.shopsphere.dashboard_name
}