resource "aws_lambda_permission" "lambda_apigateway_permission" {
  statement_id  = "apigateway-invoke-permissions"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.fare_calculation.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn = "${var.apigateway_arn}/*/*/*"
}

resource "aws_lambda_permission" "lambda_apigateway_permission" {
  statement_id  = "apigateway-invoke-permissions"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.trips_table_ops.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn = "${var.apigateway_arn}/*/*/*"
}