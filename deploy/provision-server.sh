#!/usr/bin/env bash
set -euo pipefail

# ===================================================
# Provision a fresh Ubuntu 24.04 Linode for this app
# Usage: chmod +x deploy/provision-server.sh
#        scp deploy/provision-server.sh root@<IP>:~
#        ssh root@<IP> ./provision-server.sh
# ===================================================

DOMAIN="${1:-laravel.carocholab.com}"
APP_DIR="/var/www/example-app"

echo "=== Updating system ==="
apt update && apt upgrade -y

echo "=== Installing Nginx ==="
apt install -y nginx

echo "=== Installing PHP 8.4 ==="
add-apt-repository -y ppa:ondrej/php
apt update
apt install -y php8.4-fpm php8.4-cli php8.4-mbstring php8.4-bcmath \
               php8.4-curl php8.4-gd php8.4-intl php8.4-opcache \
               php8.4-readline php8.4-sqlite3 php8.4-xml php8.4-zip

echo "=== Installing Composer ==="
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php composer-setup.php --install-dir=/usr/local/bin --filename=composer
php -r "unlink('composer-setup.php');"

echo "=== Installing Node.js ==="
curl -fsSL https://deb.nodesource.com/setup_22.x | bash -
apt install -y nodejs

echo "=== Creating app directory ==="
mkdir -p $APP_DIR

echo "=== Setting up Nginx config ==="
mkdir -p /etc/nginx/ssl /etc/nginx/sites-available

cat > /etc/nginx/sites-available/$DOMAIN << "NGINX"
server {
    listen 443 ssl;
    listen [::]:443 ssl;
    server_name DOMAIN_PLACEHOLDER;
    root /var/www/example-app/public;

    ssl_certificate /etc/nginx/ssl/DOMAIN_PLACEHOLDER.pem;
    ssl_certificate_key /etc/nginx/ssl/DOMAIN_PLACEHOLDER.key;

    add_header X-Frame-Options "SAMEORIGIN";
    add_header X-Content-Type-Options "nosniff";

    index index.php;
    charset utf-8;

    location / {
        try_files $uri $uri/ /index.php?$query_string;
    }

    location = /favicon.ico { access_log off; log_not_found off; }
    location = /robots.txt  { access_log off; log_not_found off; }

    error_page 404 /index.php;

    location ~ \.php$ {
        fastcgi_pass unix:/var/run/php/php8.4-fpm.sock;
        fastcgi_param SCRIPT_FILENAME $realpath_root$fastcgi_script_name;
        include fastcgi_params;
    }

    location ~ /\.(?!well-known).* {
        deny all;
    }
}

server {
    listen 80;
    listen [::]:80;
    server_name DOMAIN_PLACEHOLDER;
    return 301 https://$host$request_uri;
}
NGINX

sed -i "s/DOMAIN_PLACEHOLDER/$DOMAIN/g" /etc/nginx/sites-available/$DOMAIN
ln -sf /etc/nginx/sites-available/$DOMAIN /etc/nginx/sites-enabled/$DOMAIN
rm -f /etc/nginx/sites-enabled/default

nginx -t && systemctl reload nginx

echo "=== Disabling unused PHP-FPM versions ==="
systemctl stop php7.4-fpm php8.3-fpm 2>/dev/null || true
systemctl disable php7.4-fpm php8.3-fpm 2>/dev/null || true

echo "=== Provisioning complete ==="
echo ""
echo "Next steps (manual):"
echo "  1. Upload SSL certificates:"
echo "     scp laravel.carocholab.com.pem root@<IP>:/etc/nginx/ssl/"
echo "     scp laravel.carocholab.com.key root@<IP>:/etc/nginx/ssl/"
echo "  2. Upload .env file to $APP_DIR/.env"
echo "  3. Deploy the app via GitHub Actions"
echo ""
echo "Then the app will be live at https://$DOMAIN"
