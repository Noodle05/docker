#!/bin/sh
set -e
#TODO:Not sure if gerrit can be stopped properly...
echo "Starting Gerrit..."
exec su-exec ${GERRIT_USER} $GERRIT_SITE/bin/gerrit.sh daemon
