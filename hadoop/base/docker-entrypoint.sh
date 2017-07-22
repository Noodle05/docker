#!/bin/bash

set -e
set -x

if [ "$1" = "/start-server.sh" ]; then
    if [ "$(id -u)" = "0" ]; then
        if [ ! -d "${HADOOP_CONF_DIR}" ]; then
            mkdir -p "${HADOOP_CONF_DIR}"
        fi
        if [ ! -d "${HADOOP_DATA_DIR}" ]; then
            mkdir -p "${HADOOP_DATAG_DIR}"
        fi
        if [ ! -d "${HADOOP_PID_DIR}" ]; then
            mkdir -p "${HADOOP_PID_DIR}"
        fi
        if [ ! -d "${HADOOP_LOG_DIR}" ]; then
            mkdir -p "${HADOOP_LOG_DIR}"
        fi
        if [ ! -f "${HADOOP_ CONF_DIR}/log4j.properties" ]; then
            cp /hadoop_etc_orig/hadoop/log4j.properties "${HADOOP_CONF_DIR}"
        fi
        chown -R "${HADOOP_USER}":"${HADOOP_USER}" \
              "${HADOOP_CONF_DIR}" "${HADOOP_DATA_DIR}" "${HADOOP_PID_DIR}" "${HADOOP_LOG_DIR}"
    fi
    exec su-exec "${HADOOP_USER}" "$0" "$@"
fi

for f in "${CUSTOMIZE_SCRIPT_FOLDER}"/*; do
    source "$f"
done

exec "$@"
