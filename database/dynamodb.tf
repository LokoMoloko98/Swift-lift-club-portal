resource "aws_dynamodb_table" "blog-dynamodb-table" {
  name           = "${var.project_name}-data"
  billing_mode   = "PROVISIONED"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "BlogId"
  range_key      = "BlogTitle"

  attribute {
    name = "BlogId"
    type = "S"
  }

  attribute {
    name = "BlogTitle"
    type = "S"
  }


  ttl {
    attribute_name = "TimeToExist"
    enabled        = true
  }

  point_in_time_recovery {
    enabled = true
  }

  lifecycle {
    ignore_changes = [
      write_capacity,
      read_capacity
    ]
  }

  tags = {
    Name        = "${var.project_name}-dynamodb-table"
    Environment = "production"
    Costs       = "${var.project_name}"
  }
}