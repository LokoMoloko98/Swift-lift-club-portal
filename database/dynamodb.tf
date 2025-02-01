resource "aws_dynamodb_table" "users-dynamodb-table" {
  name           = "${var.project_name}-users"
  billing_mode   = "PROVISIONED"
  read_capacity  = 20
  write_capacity = 20
  

  attribute {
    name = "passenger_id"
    type = "S"
  }

  attribute {
    name = "passenger_name"
    type = "S"
  }

  hash_key       = "user_id"   # Partition Key
  range_key = "trip_date_time" # Sort Key

  # Enable stream if needed for real-time updates
  stream_enabled   = true
  stream_view_type = "NEW_IMAGE" # Capture new image of the item after modification

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

  attribute {
    name = "passenger_id"
    type = "S"
  }

  attribute {
    name = "trip_date_time"
    type = "S"
  }

  # Table Keys
  hash_key  = "passenger_id"   # Partition Key
  range_key = "trip_date_time" # Sort Key

  # Enable stream if needed for real-time updates
  stream_enabled   = true
  stream_view_type = "NEW_IMAGE" # Capture new image of the item after modification

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


