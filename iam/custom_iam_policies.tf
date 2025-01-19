resource "aws_iam_role_policy" "dynamodb-lambda-policy" {
  name = "${var.project_name}-dynamodb-lambdapolicy"
  role = aws_iam_role.moloko-blog-lambda-role.id
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : ["dynamodb:*"],
        "Resource" : "${var.dynamodb-arn}"
      }
    ]
  })
}
