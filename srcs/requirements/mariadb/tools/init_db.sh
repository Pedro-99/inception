#!/bin/bash

set -e

if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing MariaDB data directory..."
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql

    cat > /tmp/init.sql <<EOF
CREATE DATABASE IF NOT EXISTS $WP_DB;
CREATE USER IF NOT EXISTS '$WP_USER'@'%' IDENTIFIED BY '$WP_USER_PASS';
GRANT ALL PRIVILEGES ON $WP_DB.* TO '$WP_USER'@'%';
FLUSH PRIVILEGES;
EOF

    exec mariadbd-safe --datadir=/var/lib/mysql --bind-address=0.0.0.0 --port="$MARIADB_PORT" --init-file=/tmp/init.sql
else
    echo "MariaDB data directory already initialized."
    exec mariadbd-safe --datadir=/var/lib/mysql --bind-address=0.0.0.0 --port="$MARIADB_PORT"
fi