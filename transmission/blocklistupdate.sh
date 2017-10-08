#!/bin/sh -e
#

set -e

BLOCKLIST_FILE=/etc/transmission/blocklists.txt
BLOCKLIST_FOLDER=${CONFIG_DIR}/blocklists
TRANSMISSION_REMOTE=/usr/bin/transmission-remote
CURL_COMMAND=/usr/bin/curl
GUNZIP_COMMAND=/bin/gunzip
LOGGER_COMMAND=/usr/bin/logger

if [ -f ${BLOCKLIST_FILE} ]; then
    changed=0
    while read LINE
    do
        NAME=$(echo $LINE | awk '{print $1}')
        URL=$(echo $LINE | awk '{print $2}')
        NAME=${BLOCKLIST_FOLDER}/${NAME}
        NEWFILE=${NAME}.new
        ${LOGGER_COMMAND} -s "Getting file from ${URL} into ${NEWFIE} ..."
        ${CURL_COMMAND} -s -L $URL | ${GUNZIP_COMMAND} > ${NEWFILE}
        if [ -f ${NAME} ]; then
            newsum=$(/usr/bin/sha256sum $NEWFILE | /usr/bin/awk '{print $1}')
            oldsum=$(/usr/bin/sha256sum $NAME | /usr/bin/awk '{print $1}')
            if [ "${newsum}" = "${oldsum}" ]; then
                ${LOGGER_COMMAND} -s "File ${NAME} not changed, delete new file"
                rm ${NEWFILE}
            else
                ${LOGGER_COMMAND} -s "File ${NAME} changed, replace it with new file"
                rm ${NAME}
                mv ${NEWFILE} ${NAME}
                changed=$((changed+1))
            fi
        else
            ${LOGGER_COMMAND} -s "New file ${NAME}, just use it"
            mv ${NEWFILE} ${NAME}
            changed=$((changed+1))
        fi
    done < ${BLOCKLIST_FILE}
    if [ "${changed}" -gt 0 ]; then
        ${LOGGER_COMMAND} -s "Block list file updated, reload block list file"
        logger "Stop all jobs"
        ${TRANSMISSION_REMOTE} -n ${TRANSMISSION_RPC_USERNAME}:${TRANSMISSION_RPC_PASSWORD} --torrent all --stop
        sleep 5
        ${LOGGER_COMMAND} -s "Restart transmission service ..."
        kill -HUP 1
        sleep 5
        ${LOGGER_COMMAND} -s "Start all jobs"
        ${TRANSMISSION_REMOTE} -n ${TRANSMISSION_RPC_USERNAME}:${TRANSMISSION_RPC_PASSWORD} --torrent all --start
        if [ "$?" -ne 0 ]; then
            ${LOGGER_COMMAND} -s "Update block list to transmission error. Code: $?"
        fi
    else
        ${LOGGER_COMMAND} -s "No block list file changed, will not restart service."
    fi
fi

