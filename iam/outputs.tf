output "lambda-dynamodb-role-arn" {
  value = aws_iam_role.swift-lift-club-lambda-role.arn
}

output "amplify-service-role-arn" {
  value = aws_iam_role.AmplifyConsoleServiceRole-AmplifyRole.arn
}