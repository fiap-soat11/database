terraform {
  backend "s3" {
    bucket = "s3-fiap-soat11"
    key    = "fiap/terraform.tfstate"
    region = "us-east-1"
  }
}