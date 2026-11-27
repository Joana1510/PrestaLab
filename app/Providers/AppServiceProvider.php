<?php

namespace App\Providers;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\URL;
use Illuminate\Support\ServiceProvider;

class AppServiceProvider extends ServiceProvider
{
    public function register(): void
    {
        //
    }

    public function boot(): void
    {
        // En producción todo el tráfico va por HTTPS (la cámara y el GPS lo exigen).
        if ($this->app->environment('production')) {
            URL::forceScheme('https');
        }

        // Detecta errores temprano fuera de producción: consultas N+1 y atributos inexistentes.
        Model::shouldBeStrict(! $this->app->isProduction());

        Carbon::setLocale(config('app.locale'));
    }
}
