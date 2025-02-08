resource "aws_iam_role" "AmplifyConsoleServiceRole-AmplifyRole" {
  name = "${var.project_name}-amplify-service-role"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : "sts:AssumeRole"
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "amplify.amazonaws.com"
        }
      }
    ] }
  )
  tags = {
    tag-key = "${var.project_name}-amplify-iam-role"
  }
}

#AmplifyAdmin Execution policy
resource "aws_iam_role_policy_attachment" "amplify-service-role-aws_iam_role_policy_attachment" {
  role       = aws_iam_role.swift-lift-club-lambda-role.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess-Amplify"
                
}
