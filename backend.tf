terraform {
  backend "s3" {
    bucket         = "anju-utility-bucket-us-east-1"
    key            = "my-terraform-environment/main"
    region         = "us-east-1"
    dynamodb_table = "anju-new-table"
  }
}
