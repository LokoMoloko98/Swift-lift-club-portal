resource "aws_iam_role_policy" "dynamodb-lambda-policy" {
  name = "${var.project_name}-dynamodb-lambdapolicy"
  role = aws_iam_role.swift-lift-club-lambda-role.id
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : ["dynamodb:*"],
        "Resource" : "${var.trips-dynamodb-table-arn}"
      }
    ]
  })
}

resource "aws_iam_role_policy" "authenticated_users_api_policy" {
  name = "${var.project_name}-cognito-apigateway-policy"
  role = aws_iam_role.cognito_authenticated_role.id
  policy = jsonencode({
     "Version": "2012-10-17",
      "Statement": [
        {
          "Effect": "Allow",
          "Action": "execute-api:Invoke",
          "Resource" = "arn:aws:execute-api:${var.region}:${data.aws_caller_identity.current.account_id}:${var.apigateway_id}/*"
        }
      ]
  })
  
}
