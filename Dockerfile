FROM alpine:latest

RUN apk add --no-cache ca-certificates wget

COPY --from=ghcr.io/mubeng/mubeng:latest /usr/local/bin/mubeng /usr/local/bin/mubeng

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 8000

CMD ["/entrypoint.sh"]
