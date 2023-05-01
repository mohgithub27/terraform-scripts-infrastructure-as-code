resource "aws_s3_bucket" "s3_bucket_through_tf" {
  bucket = "demo-bucket-for-iac"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  lifecycle_rule {
    id      = "archive"
    enabled = true
    prefix  = "archive/"
    transition {
      days          = 730
      storage_class = "GLACIER"
    }
    expiration {
      days = 1825
    }
  }

  tags = {
    Name        = "non-prod-bucket"
    Environment = "Dev"
  }

}
