
Param(
  [Parameter(Mandatory = $true)][string]$DbHost,
  [Parameter(Mandatory = $true)][int]   $DbPort,
  [Parameter(Mandatory = $true)][string]$DbName,
  [Parameter(Mandatory = $true)][string]$SecretArn,
  [Parameter(Mandatory = $true)][string]$FilesList
)
$ErrorActionPreference = "Stop"

$secretJson = aws secretsmanager get-secret-value --secret-id $SecretArn --query SecretString --output text
$secret = $secretJson | ConvertFrom-Json
$user = $secret.username
$pass = $secret.password

if (-not (Get-Command mysql -ErrorAction SilentlyContinue)) {
  throw "mysql client não encontrado no PATH."
}

$attempts = 30
while ($attempts -gt 0) {
  try {
    & mysql --connect-timeout=5 -h $DbHost -P $DbPort -u $user "-p$pass" -e "SELECT 1" | Out-Null
    break
  } catch {
    Start-Sleep -Seconds 10
    $attempts -= 1
    if ($attempts -le 0) { throw "DB não respondeu a tempo." }
  }
}

$files = $FilesList -split "\s+" | Where-Object { $_ -ne "" }
foreach ($f in $files) {
  Write-Host "Executando $f ..."
  & mysql --ssl-mode=REQUIRED -h $DbHost -P $DbPort -u $user "-p$pass" $DbName -e ("source " + $f)
}
Write-Host "Todos os arquivos SQL foram executados."
