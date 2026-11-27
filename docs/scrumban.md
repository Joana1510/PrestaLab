# Scrumban en PrestaLab

Flujo continuo sin sprints fijos, con revisión semanal y demo con la DTIC.

## Columnas y reglas

| Columna | Entra cuando | Sale cuando |
|---|---|---|
| Backlog | Se crea la issue | Tiene criterios de aceptación, etiquetas y cabe en 2 días |
| Listo | Cumple la definición de "Listo" | Alguien la toma |
| En progreso (WIP 3) | Tiene responsable y rama | Hay PR abierto |
| En revisión (PR) | PR abierto con plantilla completa | Aprobado y CI en verde, fusionado en `develop` |
| En pruebas | Desplegado en staging | Aceptada contra sus criterios |
| Hecho | Cumple la definición de "Hecho" | (cerrada) |

**Límite WIP:** máximo 3 tarjetas en `En progreso`. Si está lleno, se termina o se revisa algo antes de empezar otra cosa.

## Cierre de issues
Los PR usan `Refs #n`. La issue se cierra manualmente al aceptarse en staging, y eso la mueve a `Hecho`.

## Definición de "Hecho"
CI en verde, pruebas incluidas, permisos verificados por rol, documentación al día, revisión aprobada y criterios de aceptación comprobados en staging.

## Cadencia
- Revisión semanal con demo de lo terminado.
- Reglas de las columnas revisadas cada mes.

## Métricas
- **Flujo acumulado:** Proyecto → Insights → gráfica histórica agrupada por Status.
- **Lead time** (creación → cierre):

```powershell
gh issue list --repo Joana1510/PrestaLab --state closed --limit 200 --json number,title,createdAt,closedAt |
  ConvertFrom-Json |
  ForEach-Object { [pscustomobject]@{ Issue = $_.number; Titulo = $_.title; LeadTimeDias = [math]::Round((([datetime]$_.closedAt) - ([datetime]$_.createdAt)).TotalDays, 1) } } |
  Sort-Object Issue
```

- **Cycle time** (inicio → cierre): agrega al proyecto un campo de fecha `Inicio`, llénalo al mover la tarjeta a `En progreso` y réstalo de la fecha de cierre.