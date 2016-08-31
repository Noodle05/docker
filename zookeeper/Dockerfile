FROM openjdk:8-jre-alpine
MAINTAINER Wei Gao<wei@gaofamily.org

ARG MIRROR=http://apache.mirrors.pair.com
ARG VERSION=3.4.8

LABEL name="zookeeper" version=$VERSION

ENV ZK_ID=-1
ENV ZK_SERVER_LIST=""

RUN apk add --no-cache bash \
 && apk add --no-cache --virtual .build-deps curl \
 && mkdir /opt \
 && curl -L $MIRROR/zookeeper/zookeeper-$VERSION/zookeeper-$VERSION.tar.gz | tar -xzf - -C /opt \
 && mv /opt/zookeeper-$VERSION /opt/zookeeper \
 && mkdir -p /var/lib/zookeeper \
 && rm -fr /opt/zookeeper/contrib /opt/zookeeper/docs /opt/zookeeper/recipes /opt/zookeeper/src /opt/zookeeper/dist-maven /opt/zookeeper/build.xml /opt/zookeeper/ivy.xml /opt/zookeeper/ivysettings.xml \
 && apk del .build-deps \
 && rm -fr .build-deps

EXPOSE 2181 2888 3888

WORKDIR /opt/zookeeper

VOLUME ["/opt/zookeeper/conf", "/var/lib/zookeeper"]

ADD docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["start-foreground"]
