#!/bin/bash

ROOT_PWD="$(cat /run/secrets/MYSQL_ROOT_PASSWORD)"
DB_PWD="$(cat /run/secrets/DB_PWD)"

if [ ! -d "/var/lib/mysql/mysql" ]; then
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql
    chown -R mysql:mysql /var/lib/mysql
fi


# Start MariaDB in safe mode to set up user/database
mysqld_safe --user=mysql &

# Wait for MySQL to be ready
until mysqladmin ping -uroot -p"${ROOT_PWD}" --silent; do
    echo "Waiting for MariaDB to start..."
    sleep 2
done



# -h127.0.0.1
mysql -uroot -p"${ROOT_PWD}" <<EOF
CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${DB_PWD}';
GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
EOF

   
mysqladmin -uroot -p"${ROOT_PWD}" shutdown




exec mariadbd --user=mysql