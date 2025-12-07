terraform {
  backend "s3" {
    bucket = "s3-fiap-soat"
    key    = "fiap/terraform.tfstate"
    region = "us-east-1"
  }
}