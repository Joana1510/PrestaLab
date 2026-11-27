@php
    // Elementos del menú. Cada fase agrega aquí sus módulos (y en la Fase 3 se filtran por rol).
    $items = [
        ['label' => 'Panel', 'route' => 'dashboard', 'match' => 'dashboard', 'icon' => 'home'],
        ['label' => 'Mi perfil', 'route' => 'profile.edit', 'match' => 'profile.*', 'icon' => 'user'],
    ];
@endphp

{{-- Menú lateral fijo: tableta y escritorio --}}
<aside class="fixed inset-y-0 left-0 z-30 hidden w-64 bg-navy-900 md:block">
    @include('layouts.partials.menu', ['items' => $items])
</aside>

{{-- Celular: barra superior con menú hamburguesa --}}
<div x-data="{ abierto: false }" class="md:hidden">
    <header class="sticky top-0 z-30 flex items-center justify-between bg-navy-900 px-4 pb-3 pt-[calc(0.75rem+env(safe-area-inset-top))] text-white">
        <a href="{{ route('dashboard') }}" class="flex items-center gap-2 font-bold">
            <x-application-logo class="h-7 w-7" />
            <span>{{ config('app.name') }}</span>
        </a>

        <button type="button"
                @click="abierto = true"
                class="-mr-2 inline-flex h-11 w-11 items-center justify-center rounded-lg hover:bg-navy-800 focus:outline-none focus-visible:ring-2 focus-visible:ring-brand-400"
                aria-label="Abrir menú">
            <x-icon name="bars" />
        </button>
    </header>

    <div x-show="abierto" x-cloak class="fixed inset-0 z-40" role="dialog" aria-modal="true"
         @keydown.escape.window="abierto = false">
        <div class="absolute inset-0 bg-navy-950/60" @click="abierto = false"></div>

        <aside class="absolute inset-y-0 right-0 w-72 max-w-[85%] bg-navy-900 shadow-xl">
            <button type="button"
                    @click="abierto = false"
                    class="absolute right-2 top-2 inline-flex h-11 w-11 items-center justify-center rounded-lg text-white hover:bg-navy-800 focus:outline-none focus-visible:ring-2 focus-visible:ring-brand-400"
                    aria-label="Cerrar menú">
                <x-icon name="close" />
            </button>

            @include('layouts.partials.menu', ['items' => $items])
        </aside>
    </div>
</div>

{{-- Celular: navegación inferior --}}
<nav class="fixed inset-x-0 bottom-0 z-30 border-t border-slate-200 bg-white pb-[env(safe-area-inset-bottom)] md:hidden"
     aria-label="Navegación inferior">
    <ul class="flex">
        @foreach ($items as $item)
            @php $activo = request()->routeIs($item['match']); @endphp
            <li class="flex-1">
                <a href="{{ route($item['route']) }}"
                   @class([
                       'flex min-h-[3.5rem] flex-col items-center justify-center gap-0.5 text-xs font-medium',
                       'text-brand-700' => $activo,
                       'text-slate-500' => ! $activo,
                   ])
                   @if ($activo) aria-current="page" @endif>
                    <x-icon :name="$item['icon']" class="h-6 w-6" />
                    {{ $item['label'] }}
                </a>
            </li>
        @endforeach
    </ul>
</nav>