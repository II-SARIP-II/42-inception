FROM debian:bookworm

RUN apt-get update && apt-get install -y \
    nginx \
    && rm -rf /var/lib/apt/lists/*

COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY tools/index.html /var/www/html/index.html

EXPOSE 8081

CMD ["nginx", "-g", "daemon off;"]
