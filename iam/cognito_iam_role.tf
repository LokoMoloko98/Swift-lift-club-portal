# resource "aws_iam_role" "cognito_authenticated_role" {
#   name = "${var.project_name}-authenticated-role"

#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Effect = "Allow"
#         Principal = {
#           Federated = "cognito-identity.amazonaws.com"
#         }
#         Action = "sts:AssumeRoleWithWebIdentity"
#         Condition = {
#           # "StringEquals" = {
#           #   "cognito-identity.amazonaws.com:aud" = var.cognito_identity_pool_id
#           # }
#           "ForAnyValue:StringLike" = {
#             "cognito-identity.amazonaws.com:amr" = "authenticated"
#           }
#         }
#       }
#     ]
#   })
# }