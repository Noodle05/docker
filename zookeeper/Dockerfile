FROM openjdk:8-jre-alpine
MAINTAINER Wei Gao<wei@gaofamily.org

ARG MIRROR=http://apache.mirrors.pair.com
ARG VERSION=3.4.8

LABEL name="zookeeper" version=$VERSION

ENV ZK_ID=-1
ENV ZK_SERVER_LIST=""

RUN apk add --no-cache bash \
 && apk add --no-cache --virtual .build-deps curl libarchive-tools \
 && mkdir -p /opt/zookeeper \
 && curl -s -L $MIRROR/zookeeper/zookeeper-$VERSION/zookeeper-$VERSION.tar.gz \
  | bsdtar --exclude "zookeeper*/contrib" --exclude "zookeeper*/dist-maven" --exclude "zookeeper*/recipes" --exclude "zookeeper*/src" --exclude "zookeeper*/docs" --exclude "zookeeper*/ivy*" --exclude "zookeeper*/build.xml" --strip-components 1 -C /opt/zookeeper -xf - \
 && mkdir -p /var/lib/zookeeper \
 && apk del .build-deps \
 && rm -fr .build-deps

EXPOSE 2181 2888 3888

WORKDIR /opt/zookeeper

VOLUME ["/opt/zookeeper/conf", "/var/lib/zookeeper"]

ADD docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["start-foreground"]
