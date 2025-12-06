#!/bin/bash

set -e

# Configure php-fpm to listen on the specified port
sed -i "s#listen = /run/php/php8.2-fpm.sock#listen = 0.0.0.0:${WORDPRESS_PORT}#" /etc/php/8.2/fpm/pool.d/www.conf

# Wait for MariaDB to be ready
echo "Waiting for MariaDB to be ready..."
while ! nc -z mariadb "$MARIADB_PORT"; do
    sleep 1
done
echo "MariaDB is ready!"

# Wait a bit more to ensure MariaDB is fully initialized
sleep 3

# Download WordPress if not present
if [ ! -f "wp-config.php" ]; then
    echo "Downloading WordPress..."
    wp core download --allow-root
fi

# Create wp-config.php if it doesn't exist
if [ ! -f "wp-config.php" ]; then
    echo "Creating wp-config.php..."
    wp config create --dbname="$WP_DB" --dbuser="$WP_USER" --dbpass="$WP_USER_PASS" --dbhost="mariadb:$MARIADB_PORT" --allow-root
fi

# Check if WordPress is already installed
if ! wp core is-installed --allow-root 2>/dev/null; then
    echo "Installing WordPress..."
    wp core install --url="$DOMAIN_NAME" --title="$WP_TITLE" --admin_user="$WP_ADMIN_USER" --admin_password="$WP_ADMIN_USER_PASS" --admin_email="$WP_ADMIN_MAIL" --skip-email --allow-root
    
    echo "Creating additional user..."
    wp user create "$WP_LOGIN" "$WP_LOGIN_MAIL" --role="$WP_LOGIN_ROLE" --user_pass="$WP_LOGIN_PASS" --allow-root 2>/dev/null || echo "User already exists"
    
    chmod -R 775 .
    chown -R www-data:www-data .
    
    echo "WordPress setup complete!"
else
    echo "WordPress already configured."
fi

echo "Starting php-fpm..."
php-fpm8.2 -F