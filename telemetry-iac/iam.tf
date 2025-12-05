resource "aws_iam_role" "telemetry_app_role" {
  name               = "${var.app_name}-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com", "eks.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_policy" "telemetry_s3_policy" {
  name        = "${var.app_name}-s3-access"
  description = "Allow telemetry app to read/write S3 bucket"
  policy      = data.aws_iam_policy_document.s3_access.json
}

data "aws_iam_policy_document" "s3_access" {
  statement {
    actions = ["s3:PutObject", "s3:GetObject", "s3:ListBucket"]
    resources = [
      aws_s3_bucket.telemetry_bucket.arn,
      "${aws_s3_bucket.telemetry_bucket.arn}/*"
    ]
  }
}

resource "aws_iam_policy_attachment" "attach_s3_policy" {
  name       = "${var.app_name}-s3-attach"
  roles      = [aws_iam_role.telemetry_app_role.name]
  policy_arn = aws_iam_policy.telemetry_s3_policy.arn
}