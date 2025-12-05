#!/bin/bash

set -e
service mariadb start
sleep 5

mariadb -e "CREATE DATABASE IF NOT EXISTS $WP_DB;"
mariadb -e "CREATE USER IF NOT EXISTS '$WP_USER'@'%' IDENTIFIED BY '$WP_USER_PASS';"
mariadb -e "GRANT ALL PRIVILEGES ON $WP_DB.* TO '$WP_USER'@'%' IDENTIFIED BY '$WP_USER_PASS';"
mariadb -e "FLUSH PRIVILEGES;"

mariadb-admin shutdown

mariadbd-safe --bind-address=0.0.0.0 --port=3306