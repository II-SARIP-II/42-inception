#!/usr/bin/env bash
set -e

# Lecture du secret du mot de passe
if [ -f /run/secrets/wp_user_password ]; then
    FTP_PASSWORD=$(cat /run/secrets/wp_user_password | tr -d '\r\n')
else
    FTP_PASSWORD=${FTP_PASSWORD:-"ftppassword"}
fi

# Nom de l'utilisateur transmis par docker-compose
FTP_USER=${FTP_USER:-"user42"}

# Fix PAM Debian pour les conteneurs
echo "auth required pam_unix.so nullok" > /etc/pam.d/vsftpd
echo "account required pam_unix.so" >> /etc/pam.d/vsftpd

# Création de l'utilisateur FTP s'il n'existe pas
if ! id "${FTP_USER}" >/dev/null 2>&1; then
    useradd -m -s /bin/bash "${FTP_USER}"
    usermod -aG www-data "${FTP_USER}"
fi

# Mise à jour du mot de passe et whitelist vsftpd
echo "${FTP_USER}:${FTP_PASSWORD}" | chpasswd
echo "$FTP_USER" > /etc/vsftpd.userlist

# Configuration des droits du dossier WordPress
mkdir -p /var/www/html
chown -R www-data:www-data /var/www/html
chmod -R 775 /var/www/html

exec vsftpd /etc/vsftpd/vsftpd.conf
