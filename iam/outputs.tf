output "lambda-dynamodb-role-arn" {
  value = aws_iam_role.swift-lift-club-lambda-role.arn
}

# output "cognito-authenticated-role-arn" {
#   value = aws_iam_role.cognito_authenticated_role.arn
# }