# HTTPS en desarrollo local

## Por qué
La cámara (`capture`) y la geolocalización del navegador solo funcionan en contextos
seguros (HTTPS). Probar con HTTPS desde el inicio evita sorpresas al desplegar.

## Instalación (una sola vez)
```powershell
winget install FiloSottile.mkcert
winget install CaddyServer.Caddy
```
Abre una terminal nueva para refrescar el PATH.

## Uso diario (3 terminales en la raíz del proyecto)
```powershell
php artisan serve          # http://127.0.0.1:8000
npm run dev                # Vite
./scripts/local/https.ps1  # https://localhost:8443
```
Abre **https://localhost:8443**. Esa es la URL oficial local (`APP_URL`).

## Qué hace el script
1. `mkcert -install` crea una autoridad certificadora local y la confía en Windows.
2. `mkcert` emite `certs/localhost.pem` y `certs/localhost-key.pem` (carpeta ignorada por git).
3. Caddy escucha en 8443 con ese certificado y reenvía a `php artisan serve`.

## Verificar
- El candado del navegador indica conexión segura, sin advertencias.
- En la consola del navegador, `window.isSecureContext` devuelve `true`.

## Producción
Se usa Let's Encrypt con Certbot y Nginx (Fase 13). Los certificados de mkcert **nunca** se usan fuera de local.