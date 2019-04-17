FROM alpine:3.9

# package versions
ARG DDCLIENT_VER="3.9.0"

RUN \
 echo "**** install build packages ****" && \
 apk add --no-cache --virtual=build-dependencies \
	bzip2 \
	curl \
	gcc \
	make \
	tar \
	wget && \
 echo "**** install runtime packages ****" && \
 apk add --no-cache \
	inotify-tools \
	perl \
	perl-digest-sha1 \
	perl-io-socket-ssl \
	perl-json && \
 echo "***** install perl modules ****" && \
 curl -L http://cpanmin.us | perl - App::cpanminus && \
 cpanm \
	Data::Validate::IP \
	JSON::Any && \
 echo "**** install ddclient ****" && \
 mkdir -p \
	/tmp/ddclient && \
 curl -o \
 /tmp/ddclient.tar.gz -L \
	"https://sourceforge.net/projects/ddclient/files/ddclient/ddclient-${DDCLIENT_VER}/ddclient-${DDCLIENT_VER}.tar.gz/download" && \
 tar xf \
 /tmp/ddclient.tar.gz -C \
	/tmp/ddclient --strip-components=1 && \
 install -Dm755 /tmp/ddclient/ddclient /usr/bin/ && \
 mkdir -p /var/cache/ddclient /etc/ddclient && \
 echo "**** cleanup ****" && \
 apk del --purge \
	build-dependencies && \
 rm -rf \
	/config/.cpanm \
	/root/.cpanm \
	/tmp/*

# ports and volumes
VOLUME /etc/ddclient

ENTRYPOINT [ "/usr/bin/ddclient" ]
CMD [ "-foreground" ]
