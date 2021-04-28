FROM --platform=${TARGETPLATFORM} alpine:3.13

ARG TARGETPLATFORM
ARG DOCKERIZE_ARCH
ARG DOCKERIZE_VERSION=v0.6.1

VOLUME /data
VOLUME /config

ADD certs/ /usr/local/share/ca-certificates/
RUN case ${TARGETPLATFORM} in \
      "linux/amd64") \
         DOCKERIZE_ARCH=alpine-linux-amd64 \
         ;; \
      "linux/arm64") \
         DOCKERIZE_ARCH=linux-armhf \
         ;; \
      "linux/arm/v7") \
         DOCKERIZE_ARCH=linux-armhf \
         ;; \
      "linux/386") \
         DOCKERIZE_ARCH=linux-386 \
         ;; \
    esac \
 && apk --no-cache add bash dumb-init strongswan shadow transmission-daemon transmission-cli curl jq \
 && /usr/sbin/update-ca-certificates \
 && echo "Install dockerize $DOCKERIZE_VERSION ($DOCKERIZE_ARCH)" \
 && curl -fskL "https://github.com/jwilder/dockerize/releases/download/${DOCKERIZE_VERSION}/dockerize-${DOCKERIZE_ARCH}-${DOCKERIZE_VERSION}.tar.gz" | tar xz -C /usr/bin \
 && mkdir -p /opt/transmission-ui \
 && echo "Install Combustion" \
 && curl -fskL "https://github.com/Secretmapper/combustion/archive/release.tar.gz" | tar xz -C /opt/transmission-ui \
 && echo "Install kettu" \
 && curl -fskL "https://github.com/endor/kettu/archive/master.tar.gz" | tar xz -C /opt/transmission-ui \
 && mv /opt/transmission-ui/kettu-master /opt/transmission-ui/kettu \
 && echo "Install Transmission-Web-Control" \
 && mkdir /opt/transmission-ui/transmission-web-control \
 && curl -fskL https://github.com/ronggang/twc-release/raw/master/src.tar.gz | tar xz -C /opt/transmission-ui/transmission-web-control \
 && ln -s /usr/share/transmission/web/style /opt/transmission-ui/transmission-web-control \
 && ln -s /usr/share/transmission/web/images /opt/transmission-ui/transmission-web-control \
 && ln -s /usr/share/transmission/web/javascript /opt/transmission-ui/transmission-web-control \
 && ln -s /usr/share/transmission/web/index.html /opt/transmission-ui/transmission-web-control/index.original.html \
 && rmdir /etc/ipsec.d/cacerts \
 && rm /etc/ipsec.conf \
 && rm /etc/ipsec.secrets \
 && rm /etc/strongswan.conf \
 && rm /etc/strongswan.d/charon/resolve.conf \
 && ln -s /etc/ssl/certs /etc/ipsec.d/cacerts \
 && rm -rf /tmp/* /var/tmp/* \
 && groupmod -g 1000 users \
 && useradd -u 911 -U -d /config -s /bin/false abc \
 && usermod -G users abc

ADD transmission/ /etc/transmission/
ADD strongswan/ /etc/strongswan/
ADD strongswan.conf /etc/strongswan.conf

ENV VPN_HOSTNAME=**None** \
    VPN_USERNAME=**None** \
    VPN_PASSWD=**None** \
    GLOBAL_APPLY_PERMISSIONS=true \
    TRANSMISSION_ALT_SPEED_DOWN=50 \
    TRANSMISSION_ALT_SPEED_ENABLED=false \
    TRANSMISSION_ALT_SPEED_TIME_BEGIN=540 \
    TRANSMISSION_ALT_SPEED_TIME_DAY=127 \
    TRANSMISSION_ALT_SPEED_TIME_ENABLED=false \
    TRANSMISSION_ALT_SPEED_TIME_END=1020 \
    TRANSMISSION_ALT_SPEED_UP=50 \
    TRANSMISSION_BIND_ADDRESS_IPV4=0.0.0.0 \
    TRANSMISSION_BIND_ADDRESS_IPV6=:: \
    TRANSMISSION_BLOCKLIST_ENABLED=false \
    TRANSMISSION_BLOCKLIST_URL=http://www.example.com/blocklist \
    TRANSMISSION_CACHE_SIZE_MB=4 \
    TRANSMISSION_DHT_ENABLED=true \
    TRANSMISSION_DOWNLOAD_DIR=/data/completed \
    TRANSMISSION_DOWNLOAD_LIMIT=100 \
    TRANSMISSION_DOWNLOAD_LIMIT_ENABLED=0 \
    TRANSMISSION_DOWNLOAD_QUEUE_ENABLED=true \
    TRANSMISSION_DOWNLOAD_QUEUE_SIZE=5 \
    TRANSMISSION_ENCRYPTION=1 \
    TRANSMISSION_IDLE_SEEDING_LIMIT=30 \
    TRANSMISSION_IDLE_SEEDING_LIMIT_ENABLED=false \
    TRANSMISSION_INCOMPLETE_DIR=/data/incomplete \
    TRANSMISSION_INCOMPLETE_DIR_ENABLED=true \
    TRANSMISSION_LPD_ENABLED=false \
    TRANSMISSION_MAX_PEERS_GLOBAL=200 \
    TRANSMISSION_MESSAGE_LEVEL=2 \
    TRANSMISSION_PEER_CONGESTION_ALGORITHM= \
    TRANSMISSION_PEER_ID_TTL_HOURS=6 \
    TRANSMISSION_PEER_LIMIT_GLOBAL=200 \
    TRANSMISSION_PEER_LIMIT_PER_TORRENT=50 \
    TRANSMISSION_PEER_PORT=51413 \
    TRANSMISSION_PEER_PORT_RANDOM_HIGH=65535 \
    TRANSMISSION_PEER_PORT_RANDOM_LOW=49152 \
    TRANSMISSION_PEER_PORT_RANDOM_ON_START=false \
    TRANSMISSION_PEER_SOCKET_TOS=default \
    TRANSMISSION_PEX_ENABLED=true \
    TRANSMISSION_PORT_FORWARDING_ENABLED=false \
    TRANSMISSION_PREALLOCATION=1 \
    TRANSMISSION_PREFETCH_ENABLED=1 \
    TRANSMISSION_QUEUE_STALLED_ENABLED=true \
    TRANSMISSION_QUEUE_STALLED_MINUTES=30 \
    TRANSMISSION_RATIO_LIMIT=2 \
    TRANSMISSION_RATIO_LIMIT_ENABLED=false \
    TRANSMISSION_RENAME_PARTIAL_FILES=true \
    TRANSMISSION_RPC_AUTHENTICATION_REQUIRED=false \
    TRANSMISSION_RPC_BIND_ADDRESS=0.0.0.0 \
    TRANSMISSION_RPC_ENABLED=true \
    TRANSMISSION_RPC_HOST_WHITELIST= \
    TRANSMISSION_RPC_HOST_WHITELIST_ENABLED=false \
    TRANSMISSION_RPC_PASSWORD=password \
    TRANSMISSION_RPC_PORT=9091 \
    TRANSMISSION_RPC_URL=/transmission/ \
    TRANSMISSION_RPC_USERNAME=username \
    TRANSMISSION_RPC_WHITELIST=127.0.0.1 \
    TRANSMISSION_RPC_WHITELIST_ENABLED=false \
    TRANSMISSION_SCRAPE_PAUSED_TORRENTS_ENABLED=true \
    TRANSMISSION_SCRIPT_TORRENT_DONE_ENABLED=false \
    TRANSMISSION_SCRIPT_TORRENT_DONE_FILENAME= \
    TRANSMISSION_SEED_QUEUE_ENABLED=false \
    TRANSMISSION_SEED_QUEUE_SIZE=10 \
    TRANSMISSION_SPEED_LIMIT_DOWN=100 \
    TRANSMISSION_SPEED_LIMIT_DOWN_ENABLED=false \
    TRANSMISSION_SPEED_LIMIT_UP=100 \
    TRANSMISSION_SPEED_LIMIT_UP_ENABLED=false \
    TRANSMISSION_START_ADDED_TORRENTS=true \
    TRANSMISSION_TRASH_ORIGINAL_TORRENT_FILES=false \
    TRANSMISSION_UMASK=2 \
    TRANSMISSION_UPLOAD_LIMIT=100 \
    TRANSMISSION_UPLOAD_LIMIT_ENABLED=0 \
    TRANSMISSION_UPLOAD_SLOTS_PER_TORRENT=14 \
    TRANSMISSION_UTP_ENABLED=true \
    TRANSMISSION_WATCH_DIR=/data/watch \
    TRANSMISSION_WATCH_DIR_ENABLED=true \
    TRANSMISSION_HOME=/data/transmission-home \
    TRANSMISSION_WATCH_DIR_FORCE_GENERIC=false \
    ENABLE_UFW=false \
    UFW_ALLOW_GW_NET=false \
    UFW_EXTRA_PORTS= \
    UFW_DISABLE_IPTABLES_REJECT=false \
    TRANSMISSION_WEB_UI= \
    PUID= \
    PGID= \
    TRANSMISSION_WEB_HOME= \
    DROP_DEFAULT_ROUTE= \
    WEBPROXY_ENABLED=false \
    WEBPROXY_PORT=8888

# Expose port and run
EXPOSE 9091
CMD ["dumb-init", "/etc/strongswan/start.sh"]
