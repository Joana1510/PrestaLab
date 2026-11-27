<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}" class="h-full">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">
        <meta name="csrf-token" content="{{ csrf_token() }}">
        <meta name="theme-color" content="#1b2a47">

        <title>{{ config('app.name', 'PrestaLab') }}</title>

        @vite(['resources/css/app.css', 'resources/js/app.js'])
    </head>
    <body class="min-h-full bg-navy-900 font-sans text-slate-800 antialiased">
        <div class="flex min-h-screen flex-col items-center justify-center px-4 py-10">
            <a href="/" class="mb-6 flex items-center gap-3 text-white">
                <x-application-logo class="h-12 w-12" />
                <span class="text-3xl font-bold tracking-tight">{{ config('app.name') }}</span>
            </a>

            <div class="w-full max-w-md rounded-2xl bg-white p-6 shadow-xl sm:p-8">
                {{ $slot }}
            </div>

            <p class="mt-6 text-sm text-navy-200">Control de préstamos · DTIC · UTTEC</p>
        </div>
    </body>
</html>