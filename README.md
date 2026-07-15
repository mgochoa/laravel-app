# GamerTag

A Laravel 13 application — visit at **[https://laravel.carocholab.com](https://laravel.carocholab.com)**

## Requirements

- PHP ≥ 8.3
- Composer
- Node.js ≥ 22
- SQLite

## Setup

```bash
composer install
npm install
cp .env.example .env
php artisan key:generate
php artisan migrate
npm run build
```

Then start the dev server:

```bash
php artisan serve
```

Or use the full dev environment (server + queue + Vite):

```bash
composer run dev
```

## Testing

```bash
php artisan test
```

## Code style

PHP code is formatted via Laravel Pint:

```bash
vendor/bin/pint --format agent
```

## Design

Design decisions and frontend conventions are documented in `DESIGN.md`.

## Infrastructure

See [`terraform/README.md`](terraform/README.md) — the server, DNS, SSL, and firewall are all managed as code via Terraform.
