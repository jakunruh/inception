#!/bin/bash

set -ex

if [ ! -d "/var/lib/mysql/mysql" ]; then
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql
    chown -R mysql:mysql /var/lib/mysql
fi

echo "Using root password: ${MYSQL_ROOT_PASSWORD}"
echo "DB_NAME=${MYSQL_DATABASE}"
echo "DB_USER=${MYSQL_USER}"
echo "DB_PWD=${MYSQL_PASSWORD}"


# Start MariaDB in safe mode to set up user/database
mysqld_safe --user=mysql &

# Wait for MySQL to be ready
until mysqladmin ping  --silent; do
    echo "Waiting for MariaDB to start..."
    sleep 2
done

# -h127.0.0.1
mysql -uroot -p"${MYSQL_ROOT_PASSWORD}" <<EOF
CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
EOF

mysqladmin -uroot -p"${MYSQL_ROOT_PASSWORD}" shutdown

exec mariadbd --user=mysql