<?php

namespace App\Providers;

use Illuminate\Support\ServiceProvider;

/**
 * Enlaza las interfaces de repositorio (capa de dominio) con sus
 * implementaciones Eloquent (capa de infraestructura).
 *
 * Cada fase agrega aquí sus repositorios, por ejemplo:
 * EquipmentRepositoryInterface::class => EloquentEquipmentRepository::class
 */
class RepositoryServiceProvider extends ServiceProvider
{
    /**
     * @var array<class-string, class-string>
     */
    public array $bindings = [];
}
