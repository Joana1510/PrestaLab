# Guía de contribución

## Flujo de trabajo
1. Toma una issue de la columna **Listo** y muévela a **En progreso** (máximo 3 en el equipo).
2. Crea tu rama desde `develop`:
   - `feature/<descripcion-corta>` (funcionalidad)
   - `fix/<descripcion-corta>` (corrección)
   - `hotfix/<descripcion-corta>` (urgente; se crea desde `main`)
3. Haz commits con **Conventional Commits** (`feat:`, `fix:`, `docs:`, `chore:`, `test:`, `refactor:`, `ci:`).
4. Abre un Pull Request hacia `develop` con la plantilla completa y `Refs #<issue>`.
5. Mínimo 1 revisión y CI en verde (`Calidad`). Se fusiona con *Squash*.
6. `develop` → `main` solo para liberar, con PR titulado `chore(release): vX.Y.Z` y fusión con *Merge commit*.

## Antes de abrir el PR
```
vendor/bin/pint
vendor/bin/phpstan analyse
php artisan test
composer audit
```

## Reglas
- Nunca subas `.env`, contraseñas, tokens ni datos personales reales.
- El código y comentarios van en español; clases, tablas y columnas en inglés.
- Las tablas se crean solo con migraciones, nunca a mano en pgAdmin.