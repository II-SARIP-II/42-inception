FROM debian:bookworm

RUN apt-get update \
    && apt-get install -y vsftpd openssl \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/run/vsftpd/empty && chmod 555 /var/run/vsftpd/empty
RUN mkdir -p /etc/vsftpd

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -out /etc/ssl/certs/servercertificate.pem \
    -keyout /etc/ssl/private/serverkey.pem \
    -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=pgougne.42.fr"

RUN chmod 600 /etc/ssl/certs/servercertificate.pem
RUN chmod 644 /etc/ssl/private/serverkey.pem

COPY conf/vsftpd.conf /etc/vsftpd/vsftpd.conf
COPY tools/setup_ftp.sh /usr/local/bin/setup_ftp.sh
RUN chmod +x /usr/local/bin/setup_ftp.sh

EXPOSE 20 21 40000-40005

ENTRYPOINT ["setup_ftp.sh"]
