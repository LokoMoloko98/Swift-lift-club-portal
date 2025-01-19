resource "aws_lambda_function" "fare_calculation" {
  s3_bucket     = "mea-munera-lambda"
  #swift-lift-fare-calculation-1.0.1.zip is the initializing version, the version imn production will be dictated by the CI/CD pipeline
  s3_key        = "swift-lift-fare-calculation/swift-lift-fare-calculation-1.0.1.zip" 
  function_name = "swift-lift-fare-calculation"
  role          = var.lambda-role-arn
  handler       = "swift-lift-fare-calculation.lambda_handler"

  runtime = "python3.12"

  environment {
    variables = {
      Name        = "${var.project_name}-Lambda Function"
      Environment = "production"
      Costs       = "${var.project_name}"
      DYNAMODB_TABLE = var.trips-dynamodb-table-name
    }
  }
}

resource "aws_lambda_permission" "lambda_apigateway_permission" {
  statement_id  = "apigateway-invoke-permissions"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.fare_calculation.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn = "${var.apigateway_arn}/*/*/*"
}