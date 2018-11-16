#!/bin/bash

if [ "$(id -u)" = "0" ]; then
    if [ ! -d "${HADOOP_CONF_DIR}" ]; then
        mkdir -p "${HADOOP_CONF_DIR}"
    fi
    if [ ! -d "${HADOOP_DATA_DIR}" ]; then
        mkdir -p "${HADOOP_DATA_DIR}"
    fi
    if [ ! -d "${HADOOP_PID_DIR}" ]; then
        mkdir -p "${HADOOP_PID_DIR}"
    fi
    if [ ! -d "${HADOOP_LOG_DIR}" ]; then
        mkdir -p "${HADOOP_LOG_DIR}"
    fi
    if [ ! -f "${HADOOP_CONF_DIR}/log4j.properties" ]; then
        cp /hadoop_etc_orig/hadoop/log4j.properties "${HADOOP_CONF_DIR}"
    fi

    if [ ! -f "${HADOOP_CONF_DIR}/core-site.xml" ]; then
        /bin/sed -e 's|\$HADOOP_NAMENODE_URI|'"${HADOOP_NAMENODE_URI}"'|g' "${HADOOP_CONF_TEMP_DIR}/core-site.xml.tmpl" > "${HADOOP_CONF_DIR}/core-site.xml"
    fi

    chown -R "${HADOOP_USER}":"${HADOOP_USER}" \
        "${HADOOP_CONF_DIR}" "${HADOOP_DATA_DIR}" "${HADOOP_PID_DIR}" "${HADOOP_LOG_DIR}"

    shopt -s nullglob
    for f in "${ROOT_ADDITION_SCRIPTS_DIR}"/*; do
        source "$f"
    done

    exec su-exec "${HADOOP_USER}" "$0" "$@"
fi

shopt -s nullglob
for f in "${USER_ADDITION_SCRIPTS_DIR}"/*; do
    source "$f"
done

exec "$@"
