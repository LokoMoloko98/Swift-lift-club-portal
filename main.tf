module "database" {
  source       = "./database"
  project_name = var.project_name
  region       = var.region
}

module "cognito" {
  source          = "./cognito"
  project_name    = var.project_name
  region          = var.region
  lambda-role-arn = module.iam.lambda-dynamodb-role-arn
  apigateway_arn  = module.networking.apigateway_arn
}

module "iam" {
  source                   = "./iam"
  project_name             = var.project_name
  region                   = var.region
  trips-dynamodb-table-arn = module.database.trips-dynamodb-table-arn
}

module "networking" {
  source                        = "./networking"
  project_name                  = var.project_name
  region                        = var.region
  fare-calculation-function-arn = module.compute.fare-calculation-function-arn
  trips-table-ops-function-arn  = module.compute.trips-table-ops-function-arn
}

module "compute" {
  source                    = "./compute"
  region                    = var.region
  project_name              = var.project_name
  lambda-role-arn           = module.iam.lambda-dynamodb-role-arn
  apigateway_arn            = module.networking.apigateway_arn
  trips-dynamodb-table-name = module.database.trips-dynamodb-table-name
}
