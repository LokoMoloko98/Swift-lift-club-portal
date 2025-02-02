resource "aws_lambda_function" "fare_calculation" {
  s3_bucket = "mea-munera-lambda"
  #swift-lift-fare-calculation-1.0.7.zip is the initializing version, the version in production will be dictated by the CI/CD pipeline
  s3_key        = "swift-lift-fare-calculation/swift-lift-fare-calculation-1.0.7.zip"
  function_name = "swift-lift-fare-calculation"
  role          = var.lambda-role-arn
  handler       = "swift-lift-fare-calculation.lambda_handler"
  timeout       = 90
  runtime       = "python3.12"

  environment {
    variables = {
      Name           = "${var.project_name}-Lambda Function"
      Environment    = "production"
      Costs          = "${var.project_name}"
      DYNAMODB_TABLE = var.trips-dynamodb-table-name
    }
  }
}

resource "aws_lambda_function" "trips_table_ops" {
  s3_bucket = "mea-munera-lambda"
  #swift-lift-trips-table-ops-1.0.0.zip is the initializing version, the version in production will be dictated by the CI/CD pipeline
  s3_key        = "swift-lift-trips-table-ops/swift-lift-trips-table-ops-1.0.0.zip"
  function_name = "swift-lift-trips-table-ops"
  role          = var.lambda-role-arn
  handler       = "swift-lift-trips-table-ops.lambda_handler"
  timeout       = 90
  runtime       = "python3.12"

  environment {
    variables = {
      Name           = "${var.project_name}-Lambda-swift-lift-trips-table-ops"
      Environment    = "production"
      Costs          = "${var.project_name}"
      DYNAMODB_TABLE = var.trips-dynamodb-table-name
    }
  }
}

resource "aws_lambda_function" "get_user_profile" {
  s3_bucket = "mea-munera-lambda"
  #swift-lift-trips-table-ops-1.0.0.zip is the initializing version, the version in production will be dictated by the CI/CD pipeline
  s3_key        = "swift-lift-user-profile/swift-lift-user-profile-1.0.0.zip"
  function_name = "swift-lift-user-profile"
  role          = var.lambda-role-arn
  handler       = "swift-lift-user-profile.lambda_handler"
  timeout       = 90
  runtime       = "python3.12"

  environment {
    variables = {
      Name           = "${var.project_name}-Lambda-swift-lift-user-profile"
      Environment    = "production"
      Costs          = "${var.project_name}"
      DYNAMODB_TABLE = var.users-dynamodb-table-name
    }
  }
}
