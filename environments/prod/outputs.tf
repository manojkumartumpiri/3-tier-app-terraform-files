output "github_actions_role_arn" {
  description = "IAM role ARN used by GitHub Actions OIDC"
  value       = module.iam.github_actions_role_arn
}
