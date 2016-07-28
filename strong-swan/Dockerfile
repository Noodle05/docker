FROM alpine:3.4
MAINTAINER Wei Gao<wei@gaofamily.org>

ARG STRONGSWAN_VERSION=5.4.0

RUN apk add --no-cache strongswan

# Strongswan Configuration
ADD ipsec.conf /etc/ipsec.conf

ADD run.sh /run.sh

# The password is later on replaced with a random string
ENV VPN_USER user
ENV VPN_PASSWORD password
ENV VPN_PSK password

EXPOSE 4500/udp 500/udp

CMD ["/run.sh"]
