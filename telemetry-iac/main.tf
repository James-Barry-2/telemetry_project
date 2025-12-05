resource "aws_s3_bucket" "telemetry_bucket" {
  bucket = var.bucket_name

  tags = {
    Name        = "${var.app_name}-bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.telemetry_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}