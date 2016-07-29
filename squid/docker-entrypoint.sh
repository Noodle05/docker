#!/bin/sh
set -e

rm -f /var/run/squid.pid

if [ ! "$(ls -A /var/cache/squid)" ]; then
    /usr/sbin/squid -z
fi

chown squid.squid /dev/stdout
chown squid.squid /dev/stderr

exec /usr/sbin/squid -NC
