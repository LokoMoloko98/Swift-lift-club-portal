# environment variables
variable "region" {
  description = "region to create resources"
  type        = string
}

variable "project_name" {
  description = "project name"
  type        = string
}

variable "lambda-role-arn" {
  type = string
}

variable "apigateway_arn" {
  type = string
}