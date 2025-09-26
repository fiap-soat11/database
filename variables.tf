variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "project_name" {
  type    = string
  default = "academy-mysql"
}

variable "vpc_id" {
  type    = string
  default = "vpc-090a0a9ea63030de5"
}

variable "private_subnet_ids" {
  type = list(string)
  default = [
    "subnet-0283c4e2fb68b6403",
    "subnet-024bfea7401bdbc83",
  ]
}

variable "db_name" {
  type    = string
  default = "fiap"
}

variable "db_username" {
  type    = string
  default = "adminuser"
}

variable "db_engine_version" {
  type    = string
  default = null
}

variable "instance_class" {
  type    = string
  default = "db.t3.micro"
}

variable "allocated_storage" {
  type    = number
  default = 20
}

variable "max_allocated_storage" {
  type    = number
  default = 100
}

variable "kms_key_id" {
  type    = string
  default = null
}

variable "app_security_group_ids" {
  type = list(string)
  default = [
    "sg-00903f08050d8519c"
  ]
}

variable "allowed_cidr_blocks" {
  type    = list(string)
  default = []
}

variable "backup_retention_period" {
  type    = number
  default = 7
}

variable "deletion_protection" {
  type    = bool
  default = false
}

variable "enable_iam_auth" {
  type    = bool
  default = true
}

variable "enable_enhanced_monitoring" {
  type    = bool
  default = false
}

variable "monitoring_interval" {
  type    = number
  default = 60
}

variable "multi_az" {
  type    = bool
  default = false
}

variable "init_sql_paths" {
  type = list(string)
  default = [
    "1_inicializacao.sql",
    "2_dados_iniciais.sql",
  ]
}

variable "run_db_init" {
  type    = bool
  default = true
}

variable "override_init_host" {
  type    = string
  default = null
}

variable "override_init_port" {
  type    = number
  default = null
}
