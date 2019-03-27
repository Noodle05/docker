#!/bin/sh

case "$PLUTO_VERB:$1" in
up-client:)
    /etc/transmission/start.sh $PLUTO_MY_SOURCEIP
    ;;
down-client:)
    /etc/transmission/stop.sh
    ;;
esac
