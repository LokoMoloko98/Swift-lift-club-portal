module "database" {
  source       = "./database"
  project_name = var.project_name
  region       = var.region
}

module "cognito" {
  source                   = "./cognito"
  project_name             = var.project_name
  region                   = var.region
  lambda-role-arn          = module.iam.lambda-dynamodb-role-arn
  apigateway_arn           = module.networking.apigateway_arn
  domain_name              = var.domain_name
  swift_lift_club_cert_arn = module.networking.swift_lift_club_cert_arn
  hosted_zone_id           = var.hosted_zone_id
  amplify_app_id           = module.amplify.amplify_app_id
}

module "iam" {
  source                   = "./iam"
  project_name             = var.project_name
  region                   = var.region
  trips-dynamodb-table-arn = module.database.trips-dynamodb-table-arn
  apigateway_id            = module.networking.apigateway_id
  users-dynamodb-table-arn = module.database.users-dynamodb-table-arn
}

module "networking" {
  source                        = "./networking"
  project_name                  = var.project_name
  region                        = var.region
  fare-calculation-function-arn = module.compute.fare-calculation-function-arn
  trips-table-ops-function-arn  = module.compute.trips-table-ops-function-arn
  get-user-profile-function-arn = module.compute.get-user-profile-function-arn
  domain_name                   = var.domain_name
  cognito_user_pool_client_id   = module.cognito.cognito_user_pool_client_id
  cognito_user_pool_endpoint    = module.cognito.cognito_user_pool_endpoint
}

module "compute" {
  source                    = "./compute"
  region                    = var.region
  project_name              = var.project_name
  lambda-role-arn           = module.iam.lambda-dynamodb-role-arn
  apigateway_arn            = module.networking.apigateway_arn
  trips-dynamodb-table-name = module.database.trips-dynamodb-table-name
  users-dynamodb-table-name = module.database.users-dynamodb-table-name
}

module "amplify" {
  source = "./amplify"
  project_name             = var.project_name
  region                   = var.region
  lambda-role-arn          = module.iam.lambda-dynamodb-role-arn
  apigateway_arn           = module.networking.apigateway_arn
  domain_name              = var.domain_name
  swift_lift_club_cert_arn = module.networking.swift_lift_club_cert_arn
  repository_url           = var.repository_url
  amplify-service-role-arn = module.iam.amplify-service-role-arn
}
