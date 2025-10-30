resource "aws_dynamodb_table" "pedido_table" {
  name           = "pedido"
  billing_mode   = "PROVISIONED"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "pedido_id"

  attribute {
    name = "UserId"
    type = "S"
  }

  ttl {
    attribute_name = "TimeToExist"
    enabled        = true
  }

  tags = {
    Name        = "pedido-table-1"
    Environment = "production"
  }
}