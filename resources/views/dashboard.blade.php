<x-app-layout>
    <x-slot name="header">
        <h1 class="text-xl font-bold text-navy-900">Panel</h1>
    </x-slot>

    <div class="space-y-6">
        <section class="card">
            <h2 class="text-lg font-semibold text-navy-900">Hola, {{ Auth::user()->name }}</h2>
            <p class="mt-1 text-slate-600">
                La base de PrestaLab está lista. Los tableros por rol llegan en la Fase 8.
            </p>
        </section>

        <section class="card">
            <h2 class="text-lg font-semibold text-navy-900">Guía de colores</h2>
            <p class="mt-1 text-sm text-slate-600">
                Rojo solo para alertas (vencido, daño); ámbar para mantenimiento; azul para Prestado.
            </p>

            <div class="mt-4 flex flex-wrap gap-2">
                <span class="badge-disponible">Disponible</span>
                <span class="badge-prestado">Prestado</span>
                <span class="badge-mantenimiento">Mantenimiento</span>
                <span class="badge-vencido">Vencido</span>
                <span class="badge-baja">Baja</span>
            </div>

            <div class="mt-5 flex flex-col gap-3 sm:flex-row">
                <button type="button" class="btn-primary">Guardar</button>
                <button type="button" class="btn-secondary">Cancelar</button>
                <button type="button" class="btn-danger">Dar de baja</button>
            </div>
        </section>
    </div>
</x-app-layout>