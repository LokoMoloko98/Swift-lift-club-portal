output "users-dynamodb-table-arn" {
  value = aws_dynamodb_table.users-dynamodb-table.arn
}

output "trips-dynamodb-table-arn" {
  value = aws_dynamodb_table.trips-dynamodb-table.arn
}