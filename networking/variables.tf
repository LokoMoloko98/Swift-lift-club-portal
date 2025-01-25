# environment variables
variable "region" {
  description = "region to create resources"
  type        = string
}

variable "project_name" {
  description = "project name"
  type        = string
}

variable "fare-calculation-function-arn" {
  type = string
}

variable "trips-table-ops-function-arn" {
  type = string
}