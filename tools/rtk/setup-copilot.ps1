$ErrorActionPreference = "Stop"
if (-not (Get-Command rtk -ErrorAction SilentlyContinue)) {
  Write-Host "RTK não encontrado. Instale o Rust Token Killer oficial e execute novamente."
  exit 1
}
rtk gain
rtk init -g --copilot
Write-Host "GitHub Copilot configurado. Reinicie a integração se necessário."
