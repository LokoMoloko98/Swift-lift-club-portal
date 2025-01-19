#Create an IAM role
resource "aws_iam_role" "moloko-blog-lambda-role" {
  name = "${var.project_name}-iam-role"
  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    tag-key = "${var.project_name}-iam-role"
  }
}

#Lambda Execution policy
resource "aws_iam_role_policy_attachment" "lambda_policy" {
  role       = aws_iam_role.moloko-blog-lambda-role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

#SSM policy 1
resource "aws_iam_role_policy_attachment" "SSM-role-attachment" {
  role       = aws_iam_role.moloko-blog-lambda-role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

#Route53 policy
resource "aws_iam_role_policy_attachment" "route53-role-attachment" {
  role       = aws_iam_role.moloko-blog-lambda-role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonRoute53FullAccess"
}
