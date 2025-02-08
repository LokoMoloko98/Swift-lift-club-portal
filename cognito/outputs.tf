output "cognito_user_pool_arn" {
  value = aws_cognito_user_pool.swift_lift_club_user_pool.arn
}

output "cognito_user_pool_client_arn" {
  value = aws_cognito_user_pool_client.swift_lift_club_user_pool_client.name
}

output "cognito_user_pool_endpoint" {
  value = aws_cognito_user_pool.swift_lift_club_user_pool.endpoint
}

output "cognito_user_pool_client_id" {
  value = aws_cognito_user_pool_client.swift_lift_club_user_pool_client.id
}

# output "cognito_identity_pool_id" {
#   value = aws_cognito_identity_pool.swift_lift_club_identity_pool.id
# }