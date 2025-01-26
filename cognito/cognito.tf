resource "aws_cognito_user_pool" "swift_lift_club_user_pool" {
  name = "${var.project_name}-user-pool"
  schema {
    name                     = "email"
    attribute_data_type      = "String"
    mutable                  = true
    required                 = true
    developer_only_attribute = false
  }

  email_configuration {
    email_sending_account = "COGNITO_DEFAULT"
  }

  auto_verified_attributes = ["email"]

  password_policy {
    minimum_length    = 6
    require_lowercase = true
    require_numbers   = true
    require_uppercase = true
  }

  username_attributes = ["email"]
  username_configuration {
    case_sensitive = true
  }

  account_recovery_setting {
    recovery_mechanism {
      name     = "verified_email"
      priority = 1
    }
  }
}

resource "aws_cognito_user_pool_client" "swift_lift_club_user_pool_client" {
  user_pool_id                  = aws_cognito_user_pool.swift_lift_club_user_pool.id
  name                          = "${var.project_name}-app-client"
  supported_identity_providers = [ "COGNITO" ]
  explicit_auth_flows           = ["ALLOW_SRP_AUTH", "ALLOW_REFRESH_TOKEN_AUTH", "ALLOW_USER_PASSWORD_AUTH"]
  generate_secret               = false
  allowed_oauth_flows           = ["code"]
  prevent_user_existence_errors = "LEGACY"
  refresh_token_validity        = 1
  access_token_validity         = 1
  id_token_validity             = 1
  token_validity_units {
    access_token  = "hours"
    id_token      = "hours"
    refresh_token = "hours"
  }
}
