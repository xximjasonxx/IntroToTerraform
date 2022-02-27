
resource aws_s3_bucket bucket {
  bucket = "bucket-mytest"
  acl    = "private"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}