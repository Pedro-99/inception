#!/bin/bash

# Wait for MariaDB to be ready
until mariadb -h mariadb -u"$MARIADB_USER" -p"$MARIADB_PASSWORD" -e "SELECT 1" >/dev/null 2>&1; do
       	echo "Waiting for MariaDB to be ready..." 
	sleep 3
done

echo "MariaDB is ready!"

# Only download WordPress if not already present
if [ ! -f "wp-config.php" ]; then
    echo "Setting up WordPress..."
    wp core download --allow-root
    wp config create --dbname="$MARIADB_DATABASE" --dbuser="$MARIADB_USER" --dbpass="$MARIADB_PASSWORD" --dbhost="mariadb" --allow-root
    wp core install --url="$DOMAIN_NAME" --title="$WP_TITLE" --admin_user="$WP_ADMIN_USER" --admin_password="$WP_ADMIN_PASSWORD" --admin_email="$WP_ADMIN_EMAIL" --skip-email --allow-root
    
    chown -R www-data:www-data .
    chmod -R 775 .
else
    echo "WordPress already installed, skipping download..."
fi

# Create additional user if it doesn't exist
if ! wp user get "$WP_USER_LOGIN" --allow-root >/dev/null 2>&1; then
    echo "Creating user $WP_USER_LOGIN..."
    wp user create "$WP_USER_LOGIN" "$WP_USER_EMAIL" --user_pass="$WP_USER_PASSWORD" --role="$WP_USER_ROLE" --allow-root
else
    echo "User $WP_USER_LOGIN already exists, skipping..."
fi

exec php-fpm8.2 -F
