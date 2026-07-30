#!/bin/bash

cd /var/www/html

if [ ! -f "wp-config.php" ]; then
    wp core download --allow-root

    DB_PWD=$(cat /run/secrets/db_password)
    WP_ADMIN_PWD=$(cat /run/secrets/credentials)
    WP_USER_PWD=$(cat /run/secrets/wp_user_password)

    wp config create \
        --dbname="${MYSQL_DATABASE}" \
        --dbuser="${MYSQL_USER}" \
        --dbpass="${DB_PWD}" \
        --dbhost="mariadb" \
        --allow-root

    wp core install \
        --url="https://${DOMAIN_NAME}" \
        --title="Inception 42" \
        --admin_user="super_master" \
        --admin_password="${WP_ADMIN_PWD}" \
        --admin_email="admin@student.42.fr" \
        --skip-email \
        --allow-root

    wp user create \
        "${WP_USER}" \
        "${WP_USER_EMAIL}" \
        --role=author \
        --user_pass="${WP_USER_PWD}" \
        --allow-root

    wp config set WP_REDIS_HOST redis --allow-root
    wp config set WP_REDIS_PORT 6379 --raw --allow-root
    wp config set WP_CACHE true --raw --allow-root

    wp plugin install redis-cache --activate --allow-root
    wp plugin enable redis-cache --allow-root
fi

chown -R www-data:www-data /var/www/html

exec php-fpm8.2 -F
