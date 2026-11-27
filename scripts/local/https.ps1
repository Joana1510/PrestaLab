<#
 Inicia HTTPS local para PrestaLab: genera los certificados con mkcert (si faltan)
 y levanta Caddy como proxy inverso: https://localhost:8443 -> http://127.0.0.1:8000
 Ejecutar desde cualquier carpeta; trabaja desde la raíz del repositorio.
#>
$ErrorActionPreference = "Stop"
$raiz = Resolve-Path (Join-Path $PSScriptRoot "..\..")
Set-Location $raiz

foreach ($cmd in "mkcert", "caddy") {
    if (-not (Get-Command $cmd -ErrorAction SilentlyContinue)) {
        throw "No se encontró '$cmd'. Instálalo con winget y abre una terminal nueva (ver docs/https-local.md)."
    }
}

New-Item -ItemType Directory -Force -Path certs | Out-Null

if (-not (Test-Path "certs/localhost.pem") -or -not (Test-Path "certs/localhost-key.pem")) {
    mkcert -install
    mkcert -cert-file certs/localhost.pem -key-file certs/localhost-key.pem localhost 127.0.0.1 ::1
}

Write-Host "HTTPS local en https://localhost:8443  (Ctrl+C para detener)" -ForegroundColor Green
caddy run --config scripts/local/Caddyfile --adapter caddyfile