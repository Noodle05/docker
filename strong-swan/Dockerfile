FROM debian:stretch-slim

ENV VPN_DOMAIN="vpn.example.com"
ENV VPN_USER="test"
ENV VPN_PASSWD="MySecuredPassword"
ENV LEFT_SUBNET="0.0.0.0/0"
ENV CLIENT_IP="192.168.12.0/24,fdef:a51d:f888::/112"
ENV DNS_SERVERS="8.8.8.8,2001:4860:4860::8888"
ARG ARCH="amd64"
ARG DOCKERIZE_VERSION="v0.6.1"
ARG DOCKERIZE_URL="https://github.com/jwilder/dockerize/releases/download/v0.6.1/dockerize-linux-${ARCH}-${DOCKERIZE_VERSION}.tar.gz"

RUN apt-get update \
 && apt-get -y upgrade \
 && apt-get install --no-install-recommends -y \
    strongswan strongswan-ikev2 libstrongswan-standard-plugins \
    libcharon-extra-plugins iptables certbot procps curl \
 && curl -L "${DOCKERIZE_URL}" | tar -C /usr/local/bin -zxf - \
 && apt-get remove -y --auto-remove --purge curl \
 && apt-get clean all -y \
 && mkdir -p /templates \
 && rm -f /etc/ipsec.conf /etc/ipsec.secrets \
 && rm -rf /var/lib/apt/lists/*

ADD firewall.updown /etc/ipsec.d/firewall.updown
ADD ipsec.conf.tmpl /templates/ipsec.conf.tmpl
ADD ipsec.secrets.tmpl /templates/ipsec.secrets.tmpl
ADD start.sh /start.sh

CMD [ "/start.sh" ]
