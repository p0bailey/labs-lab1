

resource "random_id" "example" {
  byte_length = 8
}

resource "aws_s3_bucket" "example" {
  bucket = "example-bucket-$${random_id.example.hex}"
  tags = {
    Name = "My bucket ${workspace}"
  }
}

