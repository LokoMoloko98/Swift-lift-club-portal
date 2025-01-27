# environment variables
variable "region" {
  description = "region to create resources"
  type        = string
}

variable "project_name" {
  description = "project name"
  type        = string
}

variable "domain_name" {
  type = string
}

variable "hosted_zone_id" {
  type        = string
}