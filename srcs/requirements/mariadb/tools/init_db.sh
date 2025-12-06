#!/bin/bash

service mariadb start

sleep 5

mariadb -e "CREATE DATABASE IF NOT EXISTS  $MARIADB_DATABASE;"
mariadb -e "CREATE USER '$MARIADB_USER'@'%' IDENTIFIED BY '$MARIADB_PASSWORD';"
mariadb -e "GRANT ALL PRIVILEGES ON $MARIADB_DATABASE.* TO '$MARIADB_USER'@'%' IDENTIFIED BY '$MARIADB_PASSWORD';"
mariadb -e "FLUSH PRIVILEGES;"

mariadb-admin shutdown

exec mariadbd-safe --bind-address=0.0.0.0