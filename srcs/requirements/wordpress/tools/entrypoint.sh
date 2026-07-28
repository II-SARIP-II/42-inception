#!/bin/bash

cd /var/www/html

if [ ! -f "wp-config.php" ]; then
    wp core download --allow-root

    DB_PWD=$(cat /run/secrets/db_password)
    WP_ADMIN_PWD=$(cat /run/secrets/credentials)

    wp config create \
        --dbname="${MYSQL_DATABASE}" \
        --dbuser="${MYSQL_USER}" \
        --dbpass="${DB_PWD}" \
        --dbhost="mariadb:3306" \
        --allow-root

    wp core install \
        --url="${https://${DOMAIN_NAME}}" \
        --title="Inception 42" \
        --admin_user="super_master" \
        --admin_password="${WP_ADMIN_PWD}" \
        --skip-email \
        --allow-root

    wp user create \
        "${WP_USER}" \
        "${WP_USER_EMAIL}" \
        --role=author \
        --user_pass="UserPass123!" \
        --allow-root
fi

chown -R www-data:www-data /var/www/html

exec php-fpm8.2 -F