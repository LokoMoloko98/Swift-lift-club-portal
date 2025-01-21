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
  name         = "${var.project_name}-trips"
  billing_mode = "PROVISIONED"

  attribute {
    name = "passenger_id"
    type = "S" # S for String
  }

  attribute {
    name = "trip_date"
    type = "S"
  }

 # Table Keys
  hash_key  = "passenger_id" # Partition Key
  range_key = "trip_date"    # Sort Key

  # Enable stream if needed for real-time updates
  stream_enabled   = true
  stream_view_type = "NEW_IMAGE" # Capture new image of the item after modification

  # Additional attributes for storage
  attribute {
    name = "status"
    type = "S" # S for String
  }

  attribute {
    name = "route_id"
    type = "S" # S for String
  }

  attribute {
    name = "fare"
    type = "N" # N for Number
  }

  # Global secondary indexes can be added here if needed
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


