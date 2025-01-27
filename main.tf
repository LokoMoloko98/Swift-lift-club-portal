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
}

module "iam" {
  source                   = "./iam"
  project_name             = var.project_name
  region                   = var.region
  trips-dynamodb-table-arn = module.database.trips-dynamodb-table-arn
  cognito_identity_pool_id = module.cognito.cognito_identity_pool_id
  apigateway_id            = module.networking.apigateway_id
}

module "networking" {
  source                        = "./networking"
  project_name                  = var.project_name
  region                        = var.region
  fare-calculation-function-arn = module.compute.fare-calculation-function-arn
  trips-table-ops-function-arn  = module.compute.trips-table-ops-function-arn
  domain_name                   = var.domain_name
}

module "compute" {
  source                    = "./compute"
  region                    = var.region
  project_name              = var.project_name
  lambda-role-arn           = module.iam.lambda-dynamodb-role-arn
  apigateway_arn            = module.networking.apigateway_arn
  trips-dynamodb-table-name = module.database.trips-dynamodb-table-name
}
