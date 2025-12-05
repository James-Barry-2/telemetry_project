output "bucket_name" {
    description = "Name of the telemetry S3 bucket"
    value       = aws_s3_bucket.telemetry_bucket.bucket
}

output "app_iam_role" {
    description = "IAM role for telemetry app"
    value       = aws_iam_role.telemetry_app_role.name
}
