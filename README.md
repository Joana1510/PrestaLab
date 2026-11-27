# PrestaLab

Sistema web para controlar préstamos y devoluciones del equipo de los laboratorios
de la DTIC de la UTTEC, con evidencia fotográfica, ubicación y trazabilidad.

## Stack
Laravel 13 · PHP 8.3+ · PostgreSQL 18 · Blade + Tailwind CSS 3 + Alpine.js (Laravel Breeze)

## Requisitos
PHP 8.3+ (extensiones: pdo_pgsql, pgsql, mbstring, intl, gd, fileinfo, zip, openssl, curl, xml, sodium),
Composer 2, Node 24+ y PostgreSQL 18.

## Instalación local
```powershell
git clone https://github.com/Joana1510/PrestaLab.git
cd PrestaLab
composer install
Copy-Item .env.example .env
php artisan key:generate
# Edita .env: DB_PASSWORD
```
Base de datos (pgAdmin4, Query Tool, cada sentencia por separado):
```sql
CREATE ROLE prestalab_app WITH LOGIN PASSWORD 'TU_CLAVE' NOSUPERUSER NOCREATEDB NOCREATEROLE;
CREATE DATABASE prestalab OWNER prestalab_app;
CREATE DATABASE prestalab_test OWNER prestalab_app;
```
```powershell
php artisan migrate
npm install
npm run build
```

## Ejecutar (HTTPS local)
Consulta [docs/https-local.md](docs/https-local.md).
```powershell
php artisan serve
npm run dev
./scripts/local/https.ps1
```
URL: https://localhost:8443

## Calidad
```powershell
vendor\bin\pint --test        # estilo
composer analyse              # PHPStan/Larastan
php artisan test              # pruebas (usan la base prestalab_test)
composer audit                # dependencias
```

## Variables de entorno principales
| Variable | Descripción |
|---|---|
| `APP_URL` | URL pública (local: `https://localhost:8443`) |
| `APP_LOCALE` / `APP_TIMEZONE` | `es_MX` / `America/Mexico_City` |
| `DB_*` | Conexión a PostgreSQL (`DB_TIMEZONE` fija la zona de la sesión) |
| `SESSION_LIFETIME` | Minutos de inactividad antes de cerrar sesión (30) |
| `SESSION_SECURE_COOKIE` | `true` en producción |

Los secretos van solo en `.env` (nunca en el repositorio) o en GitHub Secrets.

## Flujo de trabajo
Scrumban en GitHub Projects. Ver [CONTRIBUTING.md](CONTRIBUTING.md) y [docs/scrumban.md](docs/scrumban.md).

## Documentación
- [Arquitectura por capas](docs/arquitectura.md)
- [HTTPS local](docs/https-local.md)
- [Decisiones (ADR)](docs/adr/)

## Seguridad
Ver [SECURITY.md](SECURITY.md).