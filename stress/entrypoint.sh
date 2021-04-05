#!/bin/sh
set -e

if ! type -- "$1" &> /dev/null; then
    set -- /usr/bin/stress-ng "$@"
fi

exec "$@"
