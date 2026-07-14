#!/usr/bin/env bash
set -euo pipefail

# Usage: ./deploy/provision.sh
# Runs on the server after initial deploy to configure Nginx, permissions, etc.

APP_DIR=/var/www/example-app
DOMAIN=laravel.carocholab.com

echo "=== Setting up Nginx ==="
cp deploy/nginx.conf /etc/nginx/sites-available/$DOMAIN
ln -sf /etc/nginx/sites-available/$DOMAIN /etc/nginx/sites-enabled/$DOMAIN

# Remove default site if it would conflict
rm -f /etc/nginx/sites-enabled/default

echo "=== Setting directory permissions ==="
chown -R www-data:www-data $APP_DIR/storage $APP_DIR/bootstrap/cache $APP_DIR/database
chmod -R 775 $APP_DIR/storage $APP_DIR/bootstrap/cache $APP_DIR/database

echo "=== Caching Laravel config ==="
cd $APP_DIR
php artisan config:cache
php artisan route:cache
php artisan view:cache

echo "=== Reloading Nginx ==="
nginx -t && systemctl reload nginx

echo "=== Done ==="
