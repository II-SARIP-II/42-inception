#!/usr/bin/env bash
set -e

if [ -f /run/secrets/wp_user_password ]; then
    FTP_PASSWORD=$(cat /run/secrets/wp_user_password)
else
    echo "Error: No secret for user" >&2
    echo $(cat /run/secrets/wp_user_password)
    echo $(ls /run/secrets/)
    exit 1
fi

FTP_USER=${FTP_USER:-${WP_USER}}

if [ -z "$FTP_USER" ]; then
    echo "Erreur : FTP_USER or WP_USER empty." >&2
    exit 1
fi

mkdir -p /var/run/vsftpd/empty

echo "auth required pam_unix.so nullok" > /etc/pam.d/vsftpd
echo "account required pam_unix.so" >> /etc/pam.d/vsftpd

if ! id "${FTP_USER}" >/dev/null 2>&1; then
    useradd -m -g www-data -s /bin/bash "${FTP_USER}"
fi

echo "${FTP_USER}:${FTP_PASSWORD}" | chpasswd
echo "$FTP_USER" > /etc/vsftpd.userlist

mkdir -p /var/www/html
chown -R www-data:www-data /var/www/html
chmod -R 775 /var/www/html

exec vsftpd /etc/vsftpd/vsftpd.conf
