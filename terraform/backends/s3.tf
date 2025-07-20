resource "aws_s3_bucket" "my-s3-backend-bucket" {
  bucket = "backend-bucket-for-state-file"

#     lifecycle {
#       prevent_destroy = true
#     }
}

# resource "random_id" "bucket-sufx" {
#   byte_length = 4
# }

resource "aws_s3_bucket_versioning" "enabled" { #Enabling state file Versioning
  bucket = aws_s3_bucket.my-s3-backend-bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

