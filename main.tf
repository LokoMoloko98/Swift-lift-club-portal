module "database" {
  source       = "./database"
  project_name = var.project_name
  region       = var.region
}

module "iam" {
  source       = "./iam"
  project_name = var.project_name
  region       = var.region
  dynamodb-arn = module.database.moloko-blog-dynamodb-table-arn
}

module "networking" {
  source              = "./networking"
  project_name        = var.project_name
  region              = var.region
  lambda-function-arn = module.compute.lambda-function-arn
}

module "compute" {
  source          = "./compute"
  region          = var.region
  project_name    = var.project_name
  lambda-role-arn = module.iam.lambda-dynamodb-role-arn
  apigateway_arn  = module.networking.apigateway_arn
}