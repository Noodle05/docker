FROM alpine:3.9

RUN apk --no-cache add rsyslog \
 && rm /etc/rsyslog.conf \
 && rm -fr /var/cache/apk/*

EXPOSE 514 514/udp

VOLUME [ "/var/log", "/etc/rsyslog.d" ]

COPY rsyslog.conf /etc/rsyslog.conf

ENTRYPOINT [ "rsyslogd", "-n" ]
