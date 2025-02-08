# environment variables
variable "region" {
  description = "region to create resources"
  type        = string
}

variable "project_name" {
  description = "project name"
  type        = string
}

variable "trips-dynamodb-table-arn" {
  type = string
}

variable "users-dynamodb-table-arn" {
  type = string
}

variable "apigateway_id" {
  type = string
}