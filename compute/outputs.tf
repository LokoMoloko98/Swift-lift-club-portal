output "fare-calculation-function-arn" {
  value = aws_lambda_function.fare_calculation.arn
}

output "fare-calculation-function-name" {
  value = aws_lambda_function.fare_calculation.function_name
}

output "trips-table-ops-function-arn" {
  value = aws_lambda_function.trips_table_ops.arn
}

output "trips-table-ops-function-name" {
  value = aws_lambda_function.trips_table_ops.function_name
}