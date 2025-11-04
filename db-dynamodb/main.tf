resource "aws_dynamodb_table" "pedido_table" {
  name           = "pedido"
  billing_mode   = "PROVISIONED"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "IdPedido"

  attribute {
    name = "IdPedido"
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

resource "aws_dynamodb_table" "cliente_table" {
  name           = "cliente"
  billing_mode   = "PROVISIONED"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "IdCliente"

  attribute {
    name = "IdCliente"
    type = "S"
  }

  ttl {
    attribute_name = "TimeToExist"
    enabled        = true
  }

  tags = {
    Name        = "cliente-table-1"
    Environment = "production"
  }
}