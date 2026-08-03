FROM debian:bookworm

RUN apt-get update && apt-get install -y \
    vsftpd \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/run/vsftpd/empty && chmod 555 /var/run/vsftpd/empty
RUN mkdir -p /etc/vsftpd

COPY conf/vsftpd.conf /etc/vsftpd/vsftpd.conf
COPY tools/setup_ftp.sh /usr/local/bin/setup_ftp.sh
RUN chmod +x /usr/local/bin/setup_ftp.sh

EXPOSE 20 21 40000-40005

ENTRYPOINT ["/usr/local/bin/setup_ftp.sh"]
