FROM alpine:latest
MAINTAINER Wei Gao<wei@gaofamily.org>

COPY docker-entrypoint.sh /

RUN echo "@edge http://nl.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories && \
    apk --update add curl "postgresql@edge>9.4" && \
    curl -o /usr/local/bin/gosu -sSL "https://github.com/tianon/gosu/releases/download/1.2/gosu-amd64" && \
    chmod +x /usr/local/bin/gosu && \
    chmod +x /docker-entrypoint.sh && \
    apk del curl && \
    rm /var/cache/apk/*

ENV LANG en_US.utf8 
ENV PGDATA /var/lib/postgresql/data
VOLUME /var/lib/postgresql/data


ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 5432
CMD ["postgres"]
