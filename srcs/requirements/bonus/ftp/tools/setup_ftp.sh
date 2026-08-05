#!/usr/bin/env bash
set -e

if [ -f /run/secrets/wp_user_password ]; then
    FTP_PASSWORD=$(cat /run/secrets/wp_user_password | tr -d '\r\n')
else
    echo "ERROR: Secret file /run/secrets/wp_user_password not found!" >&2
    exit 1
fi

FTP_USER=${FTP_USER:-"pgougne"}

echo "auth required pam_unix.so nullok" > /etc/pam.d/vsftpd
echo "account required pam_unix.so" >> /etc/pam.d/vsftpd

if ! id "${FTP_USER}" >/dev/null 2>&1; then
    useradd -m -s /bin/bash "${FTP_USER}"
    usermod -aG www-data "${FTP_USER}"
fi

echo "${FTP_USER}:${FTP_PASSWORD}" | chpasswd
echo "$FTP_USER" > /etc/vsftpd.userlist

mkdir -p /var/www/html
chown -R www-data:www-data /var/www/html
chmod -R 775 /var/www/html

exec vsftpd /etc/vsftpd/vsftpd.conf
