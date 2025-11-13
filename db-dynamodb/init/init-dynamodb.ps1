Write-Host "Configuração Completa do DynamoDB Local" -ForegroundColor Cyan

# Wait for DynamoDB to be ready
Write-Host "Aguardando DynamoDB Local estar disponível..." -ForegroundColor Yellow
$maxAttempts = 30
$attempt = 0
$isReady = $false

for ($i = 1; $i -le $maxAttempts; $i++) {
    try {
        $response = Invoke-WebRequest -Uri "http://localhost:8000" -UseBasicParsing -TimeoutSec 2 -ErrorAction SilentlyContinue
        Write-Host "DynamoDB Local está rodando!" -ForegroundColor Green
        $isReady = $true
        break
    }
    catch {
        if ($i -eq $maxAttempts) {
            Write-Host "Erro: DynamoDB Local não respondeu após $maxAttempts tentativas" -ForegroundColor Red
            exit 1
        }
        Start-Sleep -Seconds 1
    }
}

# Configure AWS credentials
$awsDir = "$env:USERPROFILE\.aws"
if (-not (Test-Path $awsDir)) {
    New-Item -Path $awsDir -ItemType Directory -Force | Out-Null
}

$credentialsFile = "$awsDir\credentials"
@"
[default]
aws_access_key_id=fakeAccessKey
aws_secret_access_key=fakeSecretKey
"@ | Set-Content -Path $credentialsFile

$configFile = "$awsDir\config"
@"
[default]
region = us-east-1
output = json
"@ | Set-Content -Path $configFile

# Create Pedidos table
try {
    aws dynamodb describe-table --table-name Pedidos --region us-east-1 --endpoint-url http://localhost:8000 2>$null | Out-Null
    Write-Host "Tabela 'Pedidos' já existe!" -ForegroundColor Yellow
}
catch {
    aws dynamodb create-table `
        --table-name Pedidos `
        --attribute-definitions AttributeName=IdPedido,AttributeType=N `
        --key-schema AttributeName=IdPedido,KeyType=HASH `
        --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5 `
        --region us-east-1 `
        --endpoint-url http://localhost:8000 2>$null | Out-Null

    if ($LASTEXITCODE -eq 0) {
        Write-Host "Tabela 'Pedidos' criada com sucesso!" -ForegroundColor Green
    }
    else {
        Write-Host "Erro ao criar tabela 'Pedidos'" -ForegroundColor Red
        exit 1
    }
}

# Create Clientes table
try {
    aws dynamodb describe-table --table-name Clientes --region us-east-1 --endpoint-url http://localhost:8000 2>$null | Out-Null
    Write-Host "Tabela 'Clientes' já existe!" -ForegroundColor Yellow
}
catch {
    aws dynamodb create-table `
        --table-name Clientes `
        --attribute-definitions AttributeName=Cpf,AttributeType=N `
        --key-schema AttributeName=Cpf,KeyType=HASH `
        --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5 `
        --region us-east-1 `
        --endpoint-url http://localhost:8000 2>$null | Out-Null

    if ($LASTEXITCODE -eq 0) {
        Write-Host "Tabela 'Clientes' criada com sucesso!" -ForegroundColor Green
    }
    else {
        Write-Host "Erro ao criar tabela 'Clientes'" -ForegroundColor Red
        exit 1
    }
}