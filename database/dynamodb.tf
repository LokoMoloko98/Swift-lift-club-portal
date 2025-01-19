resource "aws_dynamodb_table" "users-dynamodb-table" {
  name           = "${var.project_name}-users"
  billing_mode   = "PROVISIONED"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "user_id"

  attribute {
    name = "user_id"
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
    Name        = "${var.project_name}-users-table"
    Environment = "production"
    Costs       = "${var.project_name}"
  }
}

resource "aws_dynamodb_table" "trips-dynamodb-table" {
  name           = "${var.project_name}-trips"
  billing_mode   = "PROVISIONED"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "trip_id"

  attribute {
    name = "trip_id"
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
    Name        = "${var.project_name}-trips-table"
    Environment = "production"
    Costs       = "${var.project_name}"
  }
}