<?php

namespace Tests\Unit;

use PHPUnit\Framework\TestCase;
use RecursiveDirectoryIterator;
use RecursiveIteratorIterator;

/**
 * Protege la arquitectura por capas: los controladores no acceden
 * a la base de datos; lo hacen mediante servicios y repositorios.
 */
class ArquitecturaCapasTest extends TestCase
{
    /**
     * Controladores heredados de Breeze. En la Fase 3 se refactorizan
     * y esta lista debe quedar vacía.
     *
     * @var list<string>
     */
    private const EXCEPCIONES = ['Auth/', 'ProfileController.php'];

    public function test_existe_la_estructura_de_capas(): void
    {
        $raiz = dirname(__DIR__, 2).'/app';

        $carpetas = [
            'Http/Controllers', 'Http/Requests', 'Http/Resources',
            'Services', 'Repositories/Contracts', 'Repositories/Eloquent',
            'Models', 'Enums', 'Policies', 'Notifications',
            'Console/Commands', 'Integrations',
        ];

        foreach ($carpetas as $carpeta) {
            $this->assertDirectoryExists("{$raiz}/{$carpeta}", "Falta la carpeta app/{$carpeta}");
        }
    }

    public function test_los_controladores_no_consultan_la_base_de_datos_directamente(): void
    {
        $base = dirname(__DIR__, 2).'/app/Http/Controllers';
        $prohibido = ['DB::', '::query(', 'Facades\\DB', 'App\\Models\\'];
        $infracciones = [];

        $archivos = new RecursiveIteratorIterator(
            new RecursiveDirectoryIterator($base, RecursiveDirectoryIterator::SKIP_DOTS)
        );

        foreach ($archivos as $archivo) {
            if ($archivo->getExtension() !== 'php') {
                continue;
            }

            $ruta = str_replace('\\', '/', substr($archivo->getPathname(), strlen($base) + 1));

            if ($this->esExcepcion($ruta)) {
                continue;
            }

            $contenido = file_get_contents($archivo->getPathname());

            foreach ($prohibido as $texto) {
                if (str_contains($contenido, $texto)) {
                    $infracciones[] = "{$ruta} usa '{$texto}'";
                }
            }
        }

        $this->assertSame([], $infracciones, 'Los controladores deben llamar a servicios, no a la BD.');
    }

    private function esExcepcion(string $ruta): bool
    {
        foreach (self::EXCEPCIONES as $excepcion) {
            if ($ruta === $excepcion || str_starts_with($ruta, $excepcion)) {
                return true;
            }
        }

        return false;
    }
}
