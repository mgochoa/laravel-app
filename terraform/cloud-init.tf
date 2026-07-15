# Cloud-init: one-time bootstrap of the Linode.
# After the VM boots, cloud-init installs Nginx, PHP 8.4, Composer, and Node.js.
# Nginx site configs and application code are deployed separately via GitHub Actions.

data "cloudinit_config" "bootstrap" {
  gzip          = false
  base64_encode = false

  part {
    content_type = "text/cloud-config"
    content      = <<-EOF
    #cloud-config
    package_update: true
    package_upgrade: false

    packages:
      - nginx
      - software-properties-common
      - ca-certificates
      - curl
      - gnupg
      - unzip
      - git

    runcmd:
      # PHP 8.4 from the ondrej PPA
      - add-apt-repository -y ppa:ondrej/php
      - apt-get update -q
      - apt-get install -y -q php8.4-fpm php8.4-cli php8.4-mbstring php8.4-bcmath php8.4-curl php8.4-gd php8.4-intl php8.4-opcache php8.4-readline php8.4-sqlite3 php8.4-xml php8.4-zip

      # Composer (latest stable)
      - php -r "copy('https://getcomposer.org/installer', '/tmp/composer-setup.php');"
      - php /tmp/composer-setup.php --install-dir=/usr/local/bin --filename=composer --quiet
      - php -r "unlink('/tmp/composer-setup.php');"

      # Node.js 22.x LTS
      - curl -fsSL https://deb.nodesource.com/setup_22.x | bash -
      - apt-get install -y -q nodejs

      # Create app directories and SSL cert directory
      - mkdir -p /var/www/example-app /var/www/example-app-dev /etc/nginx/ssl /etc/nginx/sites-available
      - chown -R www-data:www-data /var/www/example-app /var/www/example-app-dev

      # Disable default Nginx site so it doesn't conflict
      - rm -f /etc/nginx/sites-enabled/default

      # Tune PHP-FPM for a 2 GB box
      - sed -i 's/^pm.max_children = .*/pm.max_children = 10/' /etc/php/8.4/fpm/pool.d/www.conf
      - sed -i 's/^pm.start_servers = .*/pm.start_servers = 2/' /etc/php/8.4/fpm/pool.d/www.conf
      - sed -i 's/^pm.min_spare_servers = .*/pm.min_spare_servers = 1/' /etc/php/8.4/fpm/pool.d/www.conf
      - sed -i 's/^pm.max_spare_servers = .*/pm.max_spare_servers = 5/' /etc/php/8.4/fpm/pool.d/www.conf

      # Restart services to pick up changes
      - systemctl restart php8.4-fpm
      - systemctl enable php8.4-fpm
      - systemctl enable nginx

    final_message: "Bootstrap complete. System is ready for app deployment."
    EOF
  }
}
