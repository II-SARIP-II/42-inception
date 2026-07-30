#!/usr/bin/env bash

set -e

WP_PATH="/var/www/html"

if [ -f /run/secrets/wp_user_password ]; then
    FTP_PASSWORD=$(cat /run/secrets/wp_user_password | tr -d '\r\n')
else
    FTP_PASSWORD=${FTP_PASSWORD:-"ftppassword"}
fi

FTP_USER=${FTP_USER:-"pgougne"}

touch /var/log/vsftpd.log
chmod 666 /var/log/vsftpd.log

if ! id "${FTP_USER}" >/dev/null 2>&1; then
    useradd -m -s /bin/bash "${FTP_USER}"
    echo "${FTP_USER}:${FTP_PASSWORD}" | chpasswd
    usermod -aG www-data "${FTP_USER}"
    chown -R www-data:www-data "${WP_PATH}"
fi

echo "$FTP_USER" > /etc/vsftpd.userlist

exec vsftpd /etc/vsftpd/vsftpd.conf
