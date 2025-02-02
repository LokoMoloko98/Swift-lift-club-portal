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

output "get-user-profile-function-arn" {
  value = aws_lambda_function.get_user_profile.arn
}

output "get-user-profile-function-name" {
  value = aws_lambda_function.get_user_profile.function_name
}