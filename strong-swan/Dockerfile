FROM alpine:3.4
MAINTAINER Wei Gao<wei@gaofamily.org>

ARG STRONGSWAN_VERSION=5.4.0

RUN mkdir /conf \
 && apk add --no-cache strongswan

#RUN mkdir /conf \
# && apk add --no-cache openssl gmp iptables \
# && apk add --no-cache --virtual .build-deps curl linux-headers gcc g++ make libc-dev openssl-dev gmp-dev \
# && mkdir -p /work \
# && curl -L "https://download.strongswan.org/strongswan-$STRONGSWAN_VERSION.tar.gz" \
#  | tar -zxC /work \
# && cd /work/strongswan-$STRONGSWAN_VERSION \
# && ./configure --prefix=/usr --sysconfdir=/etc \
#        --enable-eap-radius \
#        --enable-eap-mschapv2 \
#        --enable-eap-identity \
#        --enable-eap-md5 \
#        --enable-eap-mschapv2 \
#        --enable-eap-tls \
#        --enable-eap-ttls \
#        --enable-eap-peap \
#        --enable-eap-tnc \
#        --enable-eap-dynamic \
#        --enable-xauth-eap \
#        --enable-openssl \
# && make -j \
# && make install \
# && cd - \
# && rm -fr /work \
# && apk del .build-deps \
# && rm -fr .build-deps

# Strongswan Configuration
ADD ipsec.conf /etc/ipsec.conf

ADD run.sh /run.sh
ADD vpn_adduser /usr/local/bin/vpn_adduser
ADD vpn_deluser /usr/local/bin/vpn_deluser
ADD vpn_setpsk /usr/local/bin/vpn_setpsk
ADD vpn_unsetpsk /usr/local/bin/vpn_unsetpsk
ADD vpn_apply /usr/local/bin/vpn_apply

# The password is later on replaced with a random string
ENV VPN_USER user
ENV VPN_PASSWORD password
ENV VPN_PSK password

VOLUME ["/conf"]

EXPOSE 4500/udp 500/udp

CMD ["/run.sh"]
