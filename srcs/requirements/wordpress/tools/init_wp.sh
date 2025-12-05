#!/bin/bash

set -e

if [ ! -e "wp-config.php" ]; then
    wp core download --allow-root
    wp config create --dbname=$WP_DB --dbuser=$WP_USER --dbpass=$WP_USER_PASS --dbhost=mariadb:3306 --allow-root
    wp core install --url=$DOMAIN_NAME --title=$WP_TITLE --admin_user=$WP_ADMIN_USER --admin_password=$WP_ADMIN_USER_PASS --admin_email=$WP_ADMIN_MAIL --skip-email --allow-root
    wp user create $WP_LOGIN $WP_LOGIN_MAIL --role=$WP_LOGIN_ROLE --user_pass=$WP_LOGIN_PASS --allow-root
    
    # redis shit
    wp config set WP_REDIS_HOST $REDIS_HOST --add --allow-root
    wp config set WP_REDIS_PORT $REDIS_PORT --add --allow-root
    wp plugin install redis-cache --activate --allow-root
    wp redis enable --allow-root

    chmod -R 775 .
    chown -R www-data:www-data .

fi

php-fpm8.2 -F