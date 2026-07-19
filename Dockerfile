FROM alpine:latest
RUN apk add --no-cache ca-certificates wget
COPY --from=ghcr.io/mubeng/mubeng:latest /usr/local/bin/mubeng /usr/local/bin/mubeng
EXPOSE 8000
CMD wget -qO /tmp/proxies.txt https://cdn.jsdelivr.net/gh/proxyscrape/free-proxy-list@main/proxies/all/data.txt && mubeng -f /tmp/proxies.txt -a 0.0.0.0:8000 -r 1 -m random --rotate-on-error --remove-on-error --max-errors -1
