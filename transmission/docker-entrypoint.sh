#!/bin/sh

if [ "$(id -u)" = '0' ]; then
    if [ ! -d "${CONFIG_DIR}" ]; then
        mkdir -p "${CONFIG_DIR}"
    fi
    if [ ! -d "${DATA_DIR}/completed" ]; then
        mkdir -p "${DATA_DIR}/completed"
    fi
    if [ ! -d "${DATA_DIR}/incomplete" ]; then
        mkdir -p "${DATA_DIR}/incomplete"
    fi
    if [ ! -d "${DATA_DIR}/watch" ]; then
        mkdir -p "${DATA_DIR}/watch"
    fi
    if [ ! -d "${DATA_DIR}/transmission-home" ]; then
        mkdir -p "${DATA_DIR}/transmission-home"
    fi
    if [ ! -f "${CONFIG_DIR}/settings.json" ]; then
        dockerize -template /etc/transmission/settings.tmpl:${CONFIG_DIR}/settings.json /bin/true
    fi

    chown -R "${TRANSMISSION_USER}":"${TRANSMISSION_USER}" "${CONFIG_DIR}" "${DATA_DIR}"
    exec su-exec "${TRANSMISSION_USER}" "$0" "$@"
fi

exec $@
