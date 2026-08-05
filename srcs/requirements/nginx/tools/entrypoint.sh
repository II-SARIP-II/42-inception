#!/bin/bash

mkdir -p /etc/nginx/ssl

if [ ! -f /etc/nginx/ssl/inception.crt ]; then
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
        -out /etc/nginx/ssl/inception.crt \
        -keyout /etc/nginx/ssl/inception.key \
        -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=${DOMAIN_NAME}"
fi

sed -i "s/DOMAIN_NAME_HOLDER/${DOMAIN_NAME}/g" /etc/nginx/conf.d/default.conf
# fill the /etc/nginx/conf.d/default.comf with the DOMAIN_NAME value for every occurence of DOMAIN_NAME_HOLDER

exec nginx -g 'daemon off;'
# replace the PID 1 by nginx. -g 'daemon off;' force nginx too execute in the foreground 
