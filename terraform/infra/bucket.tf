resource "aws_s3_bucket" "my-bucket" {
    bucket = "${var.env}-bucket-${random_id.bucket_suffix.hex}"
    tags = {
        Name = "${var.env}-bucket-for-mlti-env-stp"
        Environment = var.env
    }
  
}
resource "random_id" "bucket_suffix" {
  byte_length = 4
}