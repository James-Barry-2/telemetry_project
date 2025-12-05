variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "eu-west-1"
}

variable "bucket_name" {
  description = "S3 bucket name for telemetry data"
  type        = string
  default     = "telemetry-ingestion-jb-terraform"
}

variable "app_name" {
  description = "Name of telemetry app"
  type        = string
  default     = "telemetry-app"
}