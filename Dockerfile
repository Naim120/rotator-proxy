FROM alpine:latest

RUN apk add --no-cache \
    ca-certificates \
    wget \
    iproute2 \
    busybox-extras

COPY --from=ghcr.io/mubeng/mubeng:latest /usr/local/bin/mubeng /usr/local/bin/mubeng

EXPOSE 8000

CMD ["sh","-c", "\
set -eux; \
PORT=${PORT:-8000}; \
echo \"Using PORT=$PORT\"; \
wget -qO /tmp/proxies.txt https://cdn.jsdelivr.net/gh/proxyscrape/free-proxy-list@main/proxies/all/data.txt; \
echo \"Loaded $(wc -l < /tmp/proxies.txt) proxies\"; \
mubeng -f /tmp/proxies.txt -a 0.0.0.0:${PORT} -t https://hoon.co.in -r 1 -m random --rotate-on-error --remove-on-error --max-errors -1 -v & \
PID=$!; \
sleep 5; \
echo '=== Listening sockets ==='; \
ss -lnt || true; \
wait $PID \
"]
