# ADR 0001: Decisiones iniciales

Fecha: 2026-11-27 · Estado: aceptada

## Decisiones
1. **Laravel 13 y PHP 8.3+.** Es la versión mayor vigente y es compatible con el PHP del equipo.
2. **Sin Docker en local.** El equipo trabaja nativo en Windows; el CI usa PostgreSQL como contenedor de servicio de GitHub Actions.
3. **PostgreSQL con dos bases** (`prestalab`, `prestalab_test`) y un usuario sin privilegios de superusuario.
4. **CodeQL solo para `actions` y JavaScript/TypeScript.** No soporta PHP; se compensa con PHPStan, `composer audit` y Dependabot.
5. **Arranque directo a `main`** únicamente en la Fase 0, porque Dependabot, las plantillas de issue y CodeQL programado dependen de la rama por defecto. Desde la Fase 1 todo entra por PR.
6. **Los PR usan `Refs #n`.** GitHub solo cierra issues al fusionar en la rama por defecto; el cierre se hace al aceptar en staging.
7. **Hosting:** pendiente. Opción por defecto: VPS con Nginx y Let's Encrypt (se confirma en la Fase 13).