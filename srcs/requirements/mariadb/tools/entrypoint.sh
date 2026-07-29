#!/bin/bash

if [ ! -d "/var/lib/mysql/wordpress" ]; then

    mysql_install_db --user=mysql --datadir=/var/lib/mysql > /dev/null

    mysqld --user=mysql &
    pid="$!"

    until mysqladmin ping --silent; do
        sleep 1
    done

    DB_ROOT_PWD=$(cat /run/secrets/db_root_password)
    DB_PWD=$(cat /run/secrets/db_password)

    mysql -u root <<-EOSQL
        ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PWD}';
        FLUSH PRIVILEGES;

        CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;

        CREATE USER '${MYSQL_USER}'@'%' IDENTIFIED BY '${DB_PWD}';
        GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';
        FLUSH PRIVILEGES;
EOSQL

    mysqladmin -u root -p"${DB_ROOT_PWD}" shutdown
fi

exec mysqld --user=mysql
