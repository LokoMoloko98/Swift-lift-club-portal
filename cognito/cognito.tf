resource "aws_cognito_user_pool" "swift_lift_club_user_pool" {
  name = "${var.project_name}-user-pool"
  schema {
    name                     = "email"
    attribute_data_type      = "String"
    mutable                  = true
    required                 = true
    developer_only_attribute = false
  }

  schema {
    name                     = "phone_number"
    attribute_data_type      = "String"
    mutable                  = true
    required                 = true
    developer_only_attribute = false
  }

  email_configuration {
    email_sending_account = "COGNITO_DEFAULT"
  }

  auto_verified_attributes = ["email", "phone_number"]

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

   admin_create_user_config {
    allow_admin_create_user_only = true
  }

  account_recovery_setting {
    recovery_mechanism {
      name     = "verified_email"
      priority = 1
    }
    recovery_mechanism {
      name     = "verified_phone_number"
      priority = 2
    }
  }
}

resource "aws_cognito_user_pool_client" "swift_lift_club_user_pool_client" {
  user_pool_id                  = aws_cognito_user_pool.swift_lift_club_user_pool.id
  name                          = "${var.project_name}-app-client"
  supported_identity_providers = [ "COGNITO" ]
  explicit_auth_flows           = ["ALLOW_USER_SRP_AUTH", "ALLOW_REFRESH_TOKEN_AUTH", "ALLOW_CUSTOM_AUTH"]
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

resource "aws_cognito_identity_pool" "swift_lift_club_identity_pool" {
  identity_pool_name = "${var.project_name}-identity-pool"
  allow_unauthenticated_identities = false

  cognito_identity_providers {
    client_id       = aws_cognito_user_pool_client.swift_lift_club_user_pool_client.id
    provider_name   = aws_cognito_user_pool.swift_lift_club_user_pool.endpoint
  }
}

