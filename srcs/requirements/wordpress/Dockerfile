FROM debian:bookworm

RUN apt update && apt install -y \
    php8.2-fpm \
    php8.2-mysql \
    php8.2-curl \
    php8.2-gd \
    php8.2-mbstring \
    php8.2-xml \
    php8.2-zip \
    php-redis \
    curl \
    mariadb-client \
    && rm -rf /var/lib/apt/lists/*

# fpm: PHP FastCGI Process Manager. execute php file
# mysql: communicate with mariadb
# curl, gd, mbstring, xml, zip : required extension for wordpress to manage images, encoding, extensions and themes
# php-redis: Communicate with redis
# mariadb-client: test the connexion to the databse before installing wordpress
# rm... delete apt cache

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp
# Download official wp-cli.phar, give it the correct access and move the file in a directory

RUN mkdir -p /var/www/html /run/php8
# /var/www/html -> root directory for wordpress
# /run/php8 -> PID file and sockets for php-fpm

COPY conf/www.conf /etc/php/8.2/fpm/pool.d/www.conf
# replace the default config with mine

COPY tools/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
# copy the bash script and give it access

EXPOSE 9000
# say that the container listen on the port 9000

ENTRYPOINT ["entrypoint.sh"]
# the main exec file to run a the start of the container
