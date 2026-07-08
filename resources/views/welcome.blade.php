<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>{{ config('app.name', 'Laravel') }}</title>
        @if (file_exists(public_path('build/manifest.json')) || file_exists(public_path('hot')))
            @vite(['resources/css/app.css', 'resources/js/app.js'])
        @endif
    </head>
    <body>
        <section class="hero is-fullheight is-dark">
            <div class="hero-head">
                @if (Route::has('login'))
                    <nav class="navbar">
                        <div class="container">
                            <div class="navbar-end">
                                @auth
                                    <a href="{{ url('/dashboard') }}" class="navbar-item">Dashboard</a>
                                @else
                                    <a href="{{ route('login') }}" class="navbar-item">Log in</a>
                                    @if (Route::has('register'))
                                        <a href="{{ route('register') }}" class="navbar-item">Register</a>
                                    @endif
                                @endauth
                            </div>
                        </div>
                    </nav>
                @endif
            </div>
            <div class="hero-body">
                <div class="container has-text-centered">
                    <p class="title is-1">Laravel {{ app()->version() }}</p>
                    <p class="subtitle is-5">Let's get started</p>
                    <div class="buttons is-centered mt-4">
                        <a href="https://laravel.com/docs" class="button is-link" target="_blank">Documentation</a>
                        <a href="https://laracasts.com" class="button is-link" target="_blank">Laracasts</a>
                        <a href="https://cloud.laravel.com" class="button is-primary" target="_blank">Deploy now</a>
                        <a href="{{ url('/landing') }}" class="button is-light">View landing page</a>
                    </div>
                </div>
            </div>
        </section>
    </body>
</html>
