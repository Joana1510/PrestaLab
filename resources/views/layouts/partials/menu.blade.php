<div class="flex h-full flex-col text-white">
    <div class="flex h-16 items-center gap-3 px-5">
        <x-application-logo class="h-8 w-8" />
        <span class="text-lg font-bold tracking-tight">{{ config('app.name') }}</span>
    </div>

    <nav class="flex-1 space-y-1 px-3 py-4" aria-label="Principal">
        @foreach ($items as $item)
            @php $activo = request()->routeIs($item['match']); @endphp
            <a href="{{ route($item['route']) }}"
               @class([
                   'flex min-h-[2.75rem] items-center gap-3 rounded-lg px-3 py-2 text-sm font-medium transition',
                   'bg-navy-700 text-white' => $activo,
                   'text-navy-100 hover:bg-navy-800 hover:text-white' => ! $activo,
               ])
               @if ($activo) aria-current="page" @endif>
                <x-icon :name="$item['icon']" class="h-5 w-5" />
                {{ $item['label'] }}
            </a>
        @endforeach
    </nav>

    <div class="border-t border-navy-700 p-4">
        <p class="truncate text-sm font-semibold">{{ Auth::user()->name }}</p>
        <p class="truncate text-xs text-navy-200">{{ Auth::user()->email }}</p>

        <form method="POST" action="{{ route('logout') }}" class="mt-3">
            @csrf
            <button type="submit"
                    class="flex min-h-[2.75rem] w-full items-center gap-2 rounded-lg px-3 text-sm font-medium text-navy-100 hover:bg-navy-800 hover:text-white focus:outline-none focus-visible:ring-2 focus-visible:ring-brand-400">
                <x-icon name="logout" class="h-5 w-5" />
                Cerrar sesión
            </button>
        </form>
    </div>
</div>