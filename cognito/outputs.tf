output "cognito_user_pool_arn" {
  value = aws_cognito_user_pool.swift_lift_club_user_pool.arn
}

output "cognito_user_pool_client_arn" {
  value = aws_cognito_user_pool_client.swift_lift_club_user_pool_client.name
}