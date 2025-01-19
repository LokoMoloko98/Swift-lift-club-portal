resource "aws_cognito_user_pool" "swift_lift_club_user_pool" {
  name = "${var.project_name}-user-pool"
}

resource "aws_cognito_user_pool_client" "swift_lift_club_user_pool_client" {
  user_pool_id = aws_cognito_user_pool.swift_lift_club_user_pool.id
  name         = "${var.project_name}-app-client"
}
