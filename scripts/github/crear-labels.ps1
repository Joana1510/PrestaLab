<#
 Crea (o actualiza) las etiquetas de PrestaLab y elimina las predeterminadas de GitHub.
 Uso: pwsh ./scripts/github/crear-labels.ps1
#>
param(
    [string]$Repo = "Joana1510/PrestaLab"
)

$etiquetas = @(
    @{ n = "feature";          c = "0E8A16"; d = "Nueva funcionalidad o historia" },
    @{ n = "bug";              c = "D73A4A"; d = "Algo no funciona como se espera" },
    @{ n = "security";         c = "B60205"; d = "Seguridad y endurecimiento" },
    @{ n = "docs";             c = "0075CA"; d = "Documentación" },
    @{ n = "chore";            c = "5319E7"; d = "Mantenimiento, configuración, CI/CD" },
    @{ n = "opcional";         c = "BFDADC"; d = "No bloquea la versión 1.0.0" },
    @{ n = "prioridad:alta";   c = "D93F0B"; d = "Atender primero" },
    @{ n = "prioridad:media";  c = "FBCA04"; d = "Atender después de las altas" },
    @{ n = "prioridad:baja";   c = "C2E0C6"; d = "Cuando haya capacidad" }
)

foreach ($e in $etiquetas) {
    gh label create $e.n --repo $Repo --color $e.c --description $e.d --force
}

foreach ($b in "documentation", "duplicate", "enhancement", "good first issue", "help wanted", "invalid", "question", "wontfix") {
    gh label delete $b --repo $Repo --yes 2>$null
}

Write-Host "Etiquetas listas." -ForegroundColor Green