FROM arm64v8/alpine:3.8
MAINTAINER kev <noreply@easypi.pro>

RUN set -xe \
    && apk --no-cache add rsync

COPY rsyncd.* /etc/

VOLUME /share
EXPOSE 873

CMD rsync --daemon --no-detach --log-file /dev/stdout
