# banco-de-dados
Destinado aos arquivos de criação e inicialização do banco via terraform 


# Terraform AWS RDS MySQL

Este projeto provisiona um **banco de dados MySQL na AWS** usando **Terraform**, criando automaticamente:

- VPC com subnets públicas
- Internet Gateway e Route Table
- Security Group liberando acesso à porta 3306
- Subnet Group para o RDS
- Instância RDS MySQL
- Execução de script SQL inicial ('init.sql') após criação do banco

---

## Pré-requisitos

- [Terraform](https://www.terraform.io/downloads) instalado
    - https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli

- [AWS CLI](https://aws.amazon.com/cli/) configurado com suas credenciais
- Cliente MySQL instalado (necessário para executar 'init.sql' no Windows)
- Conta AWS ativa com permissões para criar VPC, RDS, Security Groups, etc.

- Criar na conta normal da aws, não usar academy, por algum motivo mágico do mundo não dá pra criar nem usuário.

## Para rodar
 - Instalar o terraform;
 - Instalar localmente o mysql para conseguir conectar local;
 - dentro da pasta "database\terraForm-rds", rode os comandos;
    - Comandos
        - 01 "terraform init", para criar o banco e tabelas, e vai também colocar os dados iniciais;
        - 02 "terraform apply", vai de fato aplicar na aws

