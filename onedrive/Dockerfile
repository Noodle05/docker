FROM debian:stretch

ENV CONFIG_DIR="/config"
ENV DOCUMENT_DIR="/data"

RUN apt update \
 && apt -y upgrade \
 && apt install --no-install-recommends -y curl ca-certificates \
      libcurl4-openssl-dev libsqlite3-dev git make binutils gcc cpp xz-utils gpg \
 && curl -fsS https://dlang.org/install.sh | bash -s dmd \
 && ln -s /root/dlang/dmd-*/linux/bin64/dmd /usr/local/bin/ \
 && cd /opt \
 && git clone https://github.com/skilion/onedrive.git \
 && cd onedrive \
 && make \
 && make install \
 && mkdir "$CONFIG_DIR" \
 && cp -f ./config "$CONFIG_DIR/"\
 && mkdir "$DOCUMENT_DIR" \
 && apt remove -y --autoremove --purge \
    libcurl4-openssl-dev libsqlite3-dev git make binutils gcc cpp xz-utils gpg \
 && apt clean all -y \
 && rm -rf /var/lib/apt/lists/* \
 && rm -fr /root/.gnupg /root/dlang \
 && rm -f /usr/local/bin/dmd

ADD entrypoint.sh /opt/entrypoint.sh

ENTRYPOINT /opt/entrypoint.sh
