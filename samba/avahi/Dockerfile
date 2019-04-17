FROM alpine:3.9
LABEL maintainer="Wei Gao <wei@gaofamily.org>"

RUN apk --no-cache --no-progress add avahi \
 && sed -i 's/#enable-dbus=yes/enable-dbus=no/g' /etc/avahi/avahi-daemon.conf \
 && rm -f /etc/avahi/services/* \
 && rm -rf /tmp/*

VOLUME /etc/avahi/services

EXPOSE 5353/udp

ENTRYPOINT ["avahi-daemon"]
