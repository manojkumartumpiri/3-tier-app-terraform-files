output "alb_logs_bucket_name" {
  value = aws_s3_bucket.alb_logs.bucket
}

output "alb_logs_bucket_arn" {
  value = aws_s3_bucket.alb_logs.arn
}
output "logs_bucket_name" {
  value = aws_s3_bucket.alb_logs.bucket
}