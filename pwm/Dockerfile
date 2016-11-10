FROM jetty:9-jre8-alpine
MAINTAINER Wei Gao<wei@gaofamily.org>

ARG PSQL_JDBC_VERSION=9.4.1211.jre7
ARG MARIADB_JDBC_VERSION=1.5.4
ARG MAVEN_CENTRAL_URL=http://central.maven.org/maven2

RUN java -jar "$JETTY_HOME/start.jar" --add-to-startd=http-forwarded \
 && apk add --no-cache --virtual .build-deps curl libarchive-tools \
 && mkdir $JETTY_BASE/webapps/ROOT/ \
 && curl -Ls "http://www.pwm-project.org/artifacts/pwm/pwm-1.8.0-SNAPSHOT-2016-11-09T23:30:39Z-pwm-bundle.zip" \
  | bsdtar --include "pwm*.war" -xOf - \
  | bsdtar -C $JETTY_BASE/webapps/ROOT -xf - \
 && mv $JETTY_BASE/webapps/ROOT/WEB-INF/log4jconfig-sample.xml $JETTY_BASE/webapps/ROOT/WEB-INF/log4jconfig.xml \
 && curl -Ls -o $JETTY_BASE/webapps/ROOT/WEB-INF/lib/postgresql.jar "$MAVEN_CENTRAL_URL/org/postgresql/postgresql/$PSQL_JDBC_VERSION/postgresql-$PSQL_JDBC_VERSION.jar" \
 && curl -Ls -o $JETTY_BASE/webapps/ROOT/WEB-INF/lib/mariadb.jar "$MAVEN_CENTRAL_URL/org/mariadb/jdbc/mariadb-java-client/$MARIADB_JDBC_VERSION/mariadb-java-client-$MARIADB_JDBC_VERSION.jar" \
 && sed -i 's/^# jetty.deploy.scanInterval=1$/jetty.deploy.scanInterval=0/g' $JETTY_BASE/start.d/deploy.ini \
 && sed -i 's/^# \(jetty.httpConfig.forwarded.*\)$/\1/g' $JETTY_BASE/start.d/http-forwarded.ini \
 && apk del .build-deps \
 && rm -fr .bulid-deps \
 && rm -fr /tmp/hsperfdata_root

ENV PWM_APPLICATIONPATH=/config

VOLUME [ "/config" ]
