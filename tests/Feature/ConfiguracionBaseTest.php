<?php

namespace Tests\Feature;

use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Support\Facades\DB;
use Tests\TestCase;

class ConfiguracionBaseTest extends TestCase
{
    use RefreshDatabase;

    public function test_la_aplicacion_usa_la_configuracion_regional_de_mexico(): void
    {
        $this->assertSame('America/Mexico_City', config('app.timezone'));
        $this->assertSame('es', config('app.locale'));
    }

    public function test_la_base_de_datos_es_postgresql_con_zona_horaria_de_mexico(): void
    {
        $this->assertSame('pgsql', DB::connection()->getDriverName());

        $zona = DB::selectOne("select current_setting('TimeZone') as zona")->zona;

        $this->assertSame('America/Mexico_City', $zona);
    }

    public function test_la_ruta_de_salud_responde(): void
    {
        $this->get('/up')->assertOk();
    }

    public function test_la_raiz_redirige_al_panel(): void
    {
        $this->get('/')->assertRedirect('/dashboard');
    }

    public function test_el_login_se_muestra_en_espanol(): void
    {
        $this->get('/login')
            ->assertOk()
            ->assertSee('Contraseña');
    }
}
