#!/bin/sh
set -x

wget -O /tmp/proxies.txt https://cdn.jsdelivr.net/gh/proxyscrape/free-proxy-list@main/proxies/all/data.txt

wc -l /tmp/proxies.txt
head /tmp/proxies.txt

exec mubeng \
    -f /tmp/proxies.txt \
    -a 0.0.0.0:8000 \
    -r 1 \
    -m random \
    --rotate-on-error \
    --remove-on-error \
    --max-errors -1
