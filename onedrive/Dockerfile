FROM debian:stretch

ENV CONFIG_DIR="/config"
ENV DOCUMENT_DIR="/data"
ARG CONFIG_ORIG_DIR="/config_org"

RUN apt update \
 && apt -y upgrade \
 && apt install --no-install-recommends -y curl ca-certificates gosu \
      libcurl4-openssl-dev libsqlite3-dev git make binutils gcc cpp xz-utils gpg libxml2 \
 && curl -fsS https://dlang.org/install.sh | bash -s ldc \
 && . /root/dlang/ldc-*/activate \
 && cd /opt \
 && git clone https://github.com/skilion/onedrive.git \
 && cd onedrive \
 && make DC=ldmd2 \
 && make install \
 && mkdir -p "${CONFIG_DIR}" "${DOCUMENT_DIR}" "${CONFIG_ORIG_DIR}" \
 && cp -f ./config "${CONFIG_ORIG_DIR}/"\
 && apt remove -y --autoremove --purge \
    libcurl4-openssl-dev libsqlite3-dev git make binutils gcc cpp xz-utils gpg libxml2 \
 && apt clean all -y \
 && rm -rf /var/lib/apt/lists/* \
 && rm -fr /root/.gnupg /root/dlang \
 && rm -f /usr/local/bin/dmd

ADD entrypoint.sh /opt/entrypoint.sh
ADD startOneDrive.sh /opt/startOneDrive.sh

ENTRYPOINT [ "/opt/entrypoint.sh" ]
CMD [ "/opt/startOneDrive.sh" ]
