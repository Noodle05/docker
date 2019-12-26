FROM debian:stretch

ENV TZ=America/Los_Angeles

RUN apt-get update \
 && DEBIAN_FRONTEND='noninteractive' apt-get install -y --no-install-recommends \
               build-essential net-tools \
               autoconf m4 bison flex g++ libtool \
               sqlite gcc binutils patch bzip2 make gettext \
               unzip zlib1g-dev libc6 gperf automake groff \
               lib32stdc++6 libncurses5 libncurses5-dev gawk \
               gitk zlib1g-dev autopoint shtool autogen \
               mtd-utils gcc-multilib gconf-editor lib32z1-dev \
               pkg-config libssl-dev automake1.11 libmnl-dev \
               libxml2-dev intltool libglib2.0-dev libstdc++5 \
               texinfo dos2unix xsltproc libnfnetlink0 \
               libcurl4-openssl-dev libgtk2.0-dev libnotify-dev \
               libevent-dev mc git re2c texlive libelf1 mc \
               linux-headers-4.9.0-11 \
 && DEBIAN_FRONTEND='noninteractive' apt-get remove -y --no-install-recommends libicu-dev \
 && dpkg --add-architecture i386 \
 && apt-get update \
 && DEBIAN_FRONTEND='noninteractive' apt-get install -y --no-install-recommends \
               libelf1:i386 libelf-dev:i386 \
 && apt-get clean all \
 && rm -fr /var/lib/apt/lists/* /tmp/* \
 && ln -snf /bin/systemctl /sbin/shutdown \
 && mkdir -p /work

ENV TARGET="arm-master"
ENV GIT_URL="https://bitbucket.org/pedro311/freshtomato-arm.git"
ENV DEST_DIR="/dest"

VOLUME "/dest"

WORKDIR /work

ADD docker-entrypoint.sh /docker-entrypoint.sh

ENTRYPOINT [ "/docker-entrypoint.sh" ]
