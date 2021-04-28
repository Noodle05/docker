FROM --platform=${TARGETPLATFORM} debian:stable-slim

ARG GOSU_VERSION=1.12
ARG DOGECOIN_VERSION=1.14.3
ARG TARGETPLATFORM

ENV DOGECOIN_DATA=/var/lib/dogecoin
ENV DOGECOIN_CONFIG_DIR=/etc/dogecoin
ENV DOGECOIN_CONFIG=${DOGECOIN_CONFIG_DIR}/dogecoin.conf

RUN useradd -r dogecoin \
 && apt-get update -y \
 && apt-get install -y curl \
 && case ${TARGETPLATFORM} in \
      "linux/amd64") \
         GOSU_ARCH=amd64 \
         DOGECOIN_ARCH=x86_64-linux-gnu \
         ;; \
      "linux/arm64") \
         GOSU_ARCH=arm64 \
         DOGECOIN_ARCH=aarch64-linux-gnu \
         ;; \
      "linux/arm/v7") \
         GOSU_ARCH=armhf \
         DOGECOIN_ARCH=arm-linux-gnueabihf \
         ;; \
      "linux/386") \
         GOSU_ARCH=i386 \
         DOGECOIN_ARCH=i686-pc-linux-gnu \
         ;; \
    esac \
 && curl -o /usr/local/bin/gosu -fSkL https://github.com/tianon/gosu/releases/download/${GOSU_VERSION}/gosu-${GOSU_ARCH} \
 && chmod +x /usr/local/bin/gosu \
 && curl -kL https://github.com/dogecoin/dogecoin/releases/download/v${DOGECOIN_VERSION}/dogecoin-${DOGECOIN_VERSION}-${DOGECOIN_ARCH}.tar.gz \
  | tar -C /opt -zxf - \
 && mv /opt/dogecoin-${DOGECOIN_VERSION} /opt/dogecoin \
 && for file in /opt/dogecoin/bin/*; do ln -snf ${file} /usr/local/bin/; done \
 && apt-get remove -y --autoremove --purge curl \
 && apt-get clean all -y \
 && rm -fr /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD docker-entrypoint.sh /entrypoint.sh

VOLUME ["/var/lib/dogecoin"]

EXPOSE 22555 22556 44555 44556 18444

ENTRYPOINT ["/entrypoint.sh"]

CMD ["dogecoind"]
