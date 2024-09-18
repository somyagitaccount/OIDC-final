resource "aws_s3_bucket" "s3_bucket" {
  bucket = "github-oidc-terraform-aws-bucket06"

  tags = {
    Name        = "github-oidc-terraform-aws-bucket"
    Environment = "Dev"
  }
}


resource "aws_dynamodb_table" "state-lock" {
  name             = "state-lock"
  hash_key         = "LockID"
  billing_mode     = "PAY_PER_REQUEST"
 
  attribute {
    name = "LockID"
    type = "S"
  }
}