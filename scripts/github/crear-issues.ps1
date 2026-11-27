<#
 Crea el milestone v1.0.0 y todas las issues del backlog de PrestaLab,
 y las agrega al tablero de GitHub Projects.
 Requisitos: gh autenticado con el permiso "project" y etiquetas ya creadas.
 Uso: pwsh ./scripts/github/crear-issues.ps1 -ProyectoNumero 1
#>
param(
    [string]$Repo = "Joana1510/PrestaLab",
    [string]$Propietario = "Joana1510",
    [Parameter(Mandatory = $true)][int]$ProyectoNumero
)

$ErrorActionPreference = "Stop"
$utf8 = New-Object System.Text.UTF8Encoding($false)
[Console]::OutputEncoding = $utf8
$OutputEncoding = $utf8

# Milestone (si ya existe, se ignora el error)
gh api "repos/$Repo/milestones" -f title="v1.0.0" -f description="Primera versión liberada de PrestaLab" 2>$null | Out-Null

$issues = @(
    @{ Titulo = "[Fase 0] Preparación y GitHub"; Etiquetas = "chore,docs,prioridad:alta"; Cuerpo = @'
## Alcance
Gobernanza del repositorio, flujo Scrumban en GitHub y base de datos PostgreSQL.

## Criterios de aceptación
- [ ] `main` y `develop` protegidas (PR, 1 revisión, CI "Calidad" en verde)
- [ ] Tablero con columnas, límite WIP 3 y reglas documentadas
- [ ] Labels, plantillas de issue/PR, CODEOWNERS, Dependabot, CodeQL y ci.yml activos
- [ ] Backlog completo creado y dentro del tablero
- [ ] Base `prestalab` y usuario `prestalab_app` (sin superusuario) verificados en pgAdmin4
'@ },

    @{ Titulo = "[Fase 1] Proyecto Laravel, Breeze, Tailwind, capas y HTTPS local"; Etiquetas = "chore,feature,prioridad:alta"; Cuerpo = @'
## Alcance
Laravel 13 con Breeze (Blade), Tailwind, Alpine, conexión a PostgreSQL, estructura por capas y HTTPS local con mkcert.

## Criterios de aceptación
- [ ] La aplicación abre por HTTPS local sin advertencias del navegador
- [ ] Conexión a PostgreSQL y `php artisan migrate` funcionando
- [ ] Carpetas por capas bajo `app/` y diagrama de capas en `/docs`
- [ ] Interfaz en es_MX, zona America/Mexico_City, tema azul marino/verde y layout responsivo
- [ ] `.env.example` sin secretos; Pint, Larastan y pruebas corren en CI
'@ },

    @{ Titulo = "[Fase 2] Migraciones, modelos, enums, factories y seeders"; Etiquetas = "feature,prioridad:alta"; Cuerpo = @'
## Alcance
Modelo de datos completo en PostgreSQL mediante migraciones.

## Criterios de aceptación
- [ ] Todas las tablas creadas por migración con `timestamptz` e índices requeridos
- [ ] Índice único parcial `loans_one_active_per_equipment` creado y probado
- [ ] Enums respaldados para roles y estados
- [ ] Factories y seeders de ejemplo solo en local/staging
- [ ] Diagrama entidad-relación en `/docs`
'@ },

    @{ Titulo = "[Fase 3] Autenticación y roles"; Etiquetas = "feature,security,prioridad:alta"; Cuerpo = @'
## Alcance
Login con correo y contraseña, roles y seguridad del acceso.

## Criterios de aceptación
- [ ] Sin registro público; comando `prestalab:create-admin` sin contraseñas por defecto
- [ ] Policies, Gates y middleware por rol; matriz de permisos documentada
- [ ] Bloqueo temporal tras 5 intentos fallidos, rate limiting y cierre por inactividad (30 min configurable)
- [ ] Cloudflare Turnstile en el login con manejo de fallo del servicio
- [ ] Bitácora de accesos correctos e incorrectos
- [ ] Pruebas automatizadas: cada rol recibe 403 donde corresponde
'@ },

    @{ Titulo = "[Fase 4] Catálogos, solicitantes y usuarios"; Etiquetas = "feature,prioridad:alta"; Cuerpo = @'
## Alcance
CRUD con repositorios y servicios para laboratorios, categorías, lugares de uso, solicitantes y usuarios.

## Criterios de aceptación
- [ ] Controladores delgados; reglas en servicios; acceso a datos en repositorios
- [ ] Solicitantes con clave única, búsqueda y alta rápida
- [ ] Usuarios: alta, cambio de rol, restablecer contraseña, activar/desactivar (baja lógica)
- [ ] Permisos por rol verificados con pruebas
'@ },

    @{ Titulo = "[Fase 5] Inventario de equipos con captura manual del código"; Etiquetas = "feature,prioridad:alta"; Cuerpo = @'
## Alcance
Alta, edición y baja lógica de equipos; identificación por código de inventario (sin escáner QR).

## Criterios de aceptación
- [ ] Campo con autoenfoque, autocompletado y validación inmediata del código
- [ ] Funciona con lectores de código USB (actúan como teclado)
- [ ] Código único (ej. PRY-014) y baja lógica sin borrar historial
- [ ] Laboratorista y Consulta sin acceso a edición (403)
'@ },

    @{ Titulo = "[Fase 6] Flujo de préstamo"; Etiquetas = "feature,prioridad:alta"; Cuerpo = @'
## Alcance
Registro de préstamo con foto, GPS, folio y comprobante.

## Criterios de aceptación
- [ ] Préstamo registrado en menos de 1 minuto
- [ ] Solo se presta equipo Disponible; sin préstamos dobles bajo concurrencia (transacción con bloqueo + índice único parcial)
- [ ] Foto de salida comprimida (máx. 1280 px, JPEG ~75) en disco privado y servida por ruta autenticada
- [ ] GPS con latitud, longitud y precisión; opción "sin GPS" si se niega el permiso
- [ ] Folio consecutivo único seguro ante concurrencia
- [ ] Comprobante PDF con folio y botón "Nuevo préstamo"
'@ },

    @{ Titulo = "[Fase 7] Devolución, vencimientos y notificaciones"; Etiquetas = "feature,prioridad:alta"; Cuerpo = @'
## Alcance
Devolución con comparación de fotos, estados Vencido/Devuelto tarde, scheduler, correo y campana.

## Criterios de aceptación
- [ ] Devolución registrada en menos de 45 segundos
- [ ] Foto de llegada junto a la de salida; estado Bueno/Con daño (con daño pasa a Mantenimiento)
- [ ] Comando programado marca préstamos Vencidos; "Devuelto tarde" si regresa después de la hora límite
- [ ] Correo y notificación en el sistema (campana) al vencer
- [ ] Pruebas del scheduler y de las notificaciones
'@ },

    @{ Titulo = "[Fase 8] Tableros por rol, listas de préstamos, equipos e historial"; Etiquetas = "feature,prioridad:alta"; Cuerpo = @'
## Alcance
Tablero por rol, pestañas Activos/Vencidos/Historial y línea de tiempo por equipo.

## Criterios de aceptación
- [ ] Tablero de Laboratorista, Administrador y Consulta ("Modo solo lectura")
- [ ] Filtros por laboratorio, categoría y fecha; búsqueda
- [ ] Vencidos identificables al instante (rojo solo para alertas)
- [ ] Historial con persona, fecha, lugar, foto y GPS; Consulta sin botones de captura
'@ },

    @{ Titulo = "[Fase 9] Reportes con Chart.js y exportación PDF/CSV"; Etiquetas = "feature,prioridad:media"; Cuerpo = @'
## Criterios de aceptación
- [ ] Filtros por rango de fechas y laboratorio
- [ ] Préstamos por semana, equipos más solicitados, incidencias y devoluciones tardías
- [ ] Exportación a PDF y CSV
- [ ] Accesible para Administrador y Consulta según la matriz de permisos
'@ },

    @{ Titulo = "[Fase 10] Respaldo, restauración y bitácora completa"; Etiquetas = "feature,security,prioridad:alta"; Cuerpo = @'
## Criterios de aceptación
- [ ] Comando artisan programado: pg_dump + carpeta de fotos
- [ ] Pantalla del Administrador con aviso por días sin respaldo
- [ ] Restauración protegida con reconfirmación de contraseña
- [ ] Bitácora con filtros por usuario, acción y fecha
- [ ] Plan de respaldo/restauración documentado
'@ },

    @{ Titulo = "[Fase 11] API REST /api/v1, Sanctum, OpenAPI e integraciones"; Etiquetas = "feature,security,docs,prioridad:alta"; Cuerpo = @'
## Alcance
Entregables 2 y 3: autenticación remota y web services propios y de terceros.

## Criterios de aceptación
- [ ] POST /api/v1/auth/login, logout con revocación, usuario actual; tokens con expiración y abilities por rol
- [ ] Endpoints de equipos, préstamos, devolución y tablero con API Resources, paginación y errores uniformes
- [ ] Documentación OpenAPI y colección Postman en `/docs`
- [ ] Integraciones de terceros (correo, Turnstile) con timeout, reintentos y `Http::fake` en pruebas
- [ ] Diagrama de secuencia de autenticación remota
'@ },

    @{ Titulo = "[Fase 12] Endurecimiento de seguridad"; Etiquetas = "security,prioridad:alta"; Cuerpo = @'
## Criterios de aceptación
- [ ] Cabeceras de seguridad por middleware (HSTS, CSP, X-Frame-Options, etc.)
- [ ] Cookies secure/http_only/same_site; APP_DEBUG=false en producción
- [ ] Checklist OWASP Top 10 aplicado al proyecto, documentado en `/docs`
- [ ] Revisión de permisos con pruebas y `composer audit` sin vulnerabilidades altas
'@ },

    @{ Titulo = "[Fase 13] Certificado TLS y despliegue"; Etiquetas = "chore,security,docs,prioridad:alta"; Cuerpo = @'
## Alcance
Entregable 1: certificado de seguridad HTTPS/TLS.

## Criterios de aceptación
- [ ] Certificado TLS emitido con renovación automática y verificado (SSL Labs/openssl)
- [ ] Nginx con redirección 80 a 443, TLS 1.2/1.3 y HSTS
- [ ] cd.yml: staging al fusionar en develop; producción al publicar release, con aprobación manual y respaldo previo
- [ ] Entornos staging y producción en GitHub Environments; secretos en GitHub Secrets
'@ },

    @{ Titulo = "[Fase 14] Pruebas finales, pulido de interfaz y manual de usuario"; Etiquetas = "chore,docs,prioridad:media"; Cuerpo = @'
## Criterios de aceptación
- [ ] Pruebas unitarias, de funcionalidad y de API en verde
- [ ] Interfaz revisada en celular, tableta y escritorio; favicon e ícono
- [ ] Manual de usuario por rol en `/docs`
'@ },

    @{ Titulo = "[Fase 15] Liberación v1.0.0"; Etiquetas = "docs,chore,prioridad:alta"; Cuerpo = @'
## Alcance
Entregable 4: políticas y normativas para la liberación.

## Criterios de aceptación
- [ ] `docs/politicas-liberacion.md`, CHANGELOG y aviso de privacidad (confirmado con el área jurídica)
- [ ] Tag v1.0.0 y GitHub Release con notas
- [ ] Acta de aceptación firmada por la DTIC
- [ ] Checklist final: metas de tiempo, evidencia al 100 %, permisos por rol, certificado, autenticación remota, web services y políticas
'@ },

    @{ Titulo = "[Opcional] Etiquetas imprimibles con el código del equipo"; Etiquetas = "feature,opcional,prioridad:baja"; Cuerpo = @'
## Criterios de aceptación
- [ ] PDF con etiqueta (código y QR de referencia); el QR no se escanea con la app
- [ ] Solo Administrador puede generarlas
'@ },

    @{ Titulo = "[Opcional] Inicio de sesión con Google (Socialite)"; Etiquetas = "feature,security,opcional,prioridad:baja"; Cuerpo = @'
## Criterios de aceptación
- [ ] Activable por variable de entorno
- [ ] Solo correos ya registrados por el Administrador (y dominio institucional si aplica)
- [ ] Documentado, con flujo en el diagrama de secuencia
'@ }
)

foreach ($i in $issues) {
    $archivo = New-TemporaryFile
    [System.IO.File]::WriteAllText($archivo.FullName, $i.Cuerpo, $utf8)
    $url = gh issue create --repo $Repo --title $i.Titulo --body-file $archivo.FullName --label $i.Etiquetas --milestone "v1.0.0" | Select-Object -Last 1
    Remove-Item $archivo.FullName
    gh project item-add $ProyectoNumero --owner $Propietario --url $url | Out-Null
    Write-Host "Creada: $url"
}

Write-Host "Backlog creado." -ForegroundColor Green