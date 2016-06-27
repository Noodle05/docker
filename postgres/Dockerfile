FROM alpine:3.4
MAINTAINER Wei Gao<wei@gaofamily.org>

COPY docker-entrypoint.sh /

RUN apk add --no-cache --virtual .build-deps curl \
 && apk add --no-cache postgresql \
 && curl -o /usr/local/bin/gosu -sSL "https://github.com/tianon/gosu/releases/download/1.9/gosu-amd64" \
 && chmod +x /usr/local/bin/gosu \
 && chmod +x /docker-entrypoint.sh \
 && apk del .build-deps \
 && rm -fr .build-deps

ENV LANG en_US.utf8 
ENV PGDATA /var/lib/postgresql/data
VOLUME [ "/var/lib/postgresql/data" ]


ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 5432
CMD ["postgres"]
