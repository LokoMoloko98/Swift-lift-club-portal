output "fare-calculation-function-arn" {
  value = aws_lambda_function.fare_calculation.arn
}

output "fare-calculation-function-name" {
  value = aws_lambda_function.fare_calculation.function_name
}