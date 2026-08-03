FROM debian:bookworm

RUN apt-get update && apt-get install -y \
    curl \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

RUN curl -sSL https://github.com/google/cadvisor/releases/download/v0.49.1/cadvisor-v0.49.1-linux-amd64 -o /usr/local/bin/cadvisor \
    && chmod +x /usr/local/bin/cadvisor

EXPOSE 8082

CMD ["/usr/local/bin/cadvisor", "-port=8082"]
