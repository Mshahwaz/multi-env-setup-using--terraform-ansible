resource "aws_dynamodb_table" "my-table" {
  name = "${var.env}-dynamodb-table"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "userID"
  attribute {
    name = "userID"
    type = "S"
  }
  tags = {
    Name = "${var.env}-dynamodb-table"
    Environment = var.env
  }
}