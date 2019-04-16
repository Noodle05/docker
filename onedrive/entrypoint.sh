#!/bin/bash

set -x

# check a refresh token exists
if [ -f "$CONFIG_DIR/refresh_token" ]; then
  echo "Found onedrive refresh token..."
else
  echo
  echo "-------------------------------------"
  echo "ONEDRIVE LOGIN REQUIRED"
  echo "-------------------------------------"
  echo "To use this container you must authorize the OneDrive Client."

  if [ -t 0 ] ; then
    echo "-------------------------------------"
    echo
  else
    echo
    echo "Please re-start start the container in interactive mode using the -it flag:"
    echo
    echo "docker run -it --rm -v /local/config/path:${CONFIG_DIR} -v /local/documents/path:${DOCUMENT_DIR} noodle05/onedrive"
    echo
    echo "Once authorized you can re-create container with interactive mode disabled."
    echo "-------------------------------------"
    echo
    exit 1
  fi

fi

[ -z $PGID ] && { PGID=1000; }
[ -z $PUID ] && { PUID=1000; }

# group for app
[ $( getent group app | wc -l ) -gt 0 ] && { groupdel app; }
groupadd -g $PGID app
# user
[ $( getent passwd app | wc -l ) -gt 0 ] && { userdel app; }
useradd -g app -u $PUID -s /bin/bash -m app

if [ ! -z "$SYNC_LIST" ]
then
  echo -n > "${CONFIG_DIR}/sync_list"
  # convert comma limited list to line-by-line and insert into the sync_list file
  echo "$SYNC_LIST" | tr -s ',' '\n' > "${CONFIG_DIR}/sync_list"
fi

chown -R app:app "${CONFIG_DIR}"
chown -R app:app "${DOCUMENT_DIR}"
su app -c "onedrive --monitor --confdir ${CONFIG_DIR} --syncdir ${DOCUMENT_DIR}"
