#!/bin/bash


if [ ! -e "wp-config.php" ]; then

    wp core download --allow-root
    wp config create --dbname=$MARIADB_DATABASE --dbuser=$MARIADB_USER --dbpass=$MARIADB_PASSWORD --dbhost=$MARIADB_HOST --allow-root

    wp core install  --url="$DOMAIN_NAME" --title=$WP_TITLE --admin_user=$WP_ADMIN_USER --admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_EMAIL --skip-email --allow-root
    wp user create $WP_USER $WP_USER_EMAIL --user_pass=$WP_USER_PASSWORD  --role=$WP_USER_ROLE --allow-root

    chown -R www-data:www-data .
    chmod -R 775 .
fi

exec php-fpm8.2 -F