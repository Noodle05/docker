FROM jetty:9-jre8-alpine
MAINTAINER Wei Gao<wei@gaofamily.org>

ARG PSQL_JDBC_VERSION=9.4.1209
ARG MYSQL_JDBC_VERSION=5.1.39

RUN java -jar "$JETTY_HOME/start.jar" --add-to-startd=http-forwarded \
 && apk add --no-cache --virtual .build-deps curl libarchive-tools \
 && mkdir $JETTY_BASE/webapps/ROOT/ \
 && curl -s -L "http://www.pwm-project.org/artifacts/pwm/pwm-1.8.0-SNAPSHOT-2016-08-28T22%3A16%3A03Z-pwm-bundle.zip" \
  | bsdtar --include "pwm*.war" -xOf - \
  | bsdtar -C $JETTY_BASE/webapps/ROOT -xf - \
 && mv $JETTY_BASE/webapps/ROOT/WEB-INF/log4jconfig-sample.xml $JETTY_BASE/webapps/ROOT/WEB-INF/log4jconfig.xml \
 && curl -s -o $JETTY_BASE/webapps/ROOT/WEB-INF/lib/postgresql.jar -L "https://jdbc.postgresql.org/download/postgresql-$PSQL_JDBC_VERSION.jar" \
 && curl -s -L "https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-$MYSQL_JDBC_VERSION.tar.gz" | bsdtar --include "*/mysql-connect*.jar" --strip-components 1 -C $JETTY_BASE/webapps/ROOT/WEB-INF/lib -xf - \
 && sed -i 's/^# jetty.deploy.scanInterval=1$/jetty.deploy.scanInterval=0/g' $JETTY_BASE/start.d/deploy.ini \
 && sed -i 's/^# \(jetty.httpConfig.forwarded.*\)$/\1/g' $JETTY_BASE/start.d/http-forwarded.ini \
 && apk del .build-deps \
 && rm -fr .bulid-deps \
 && rm -fr /tmp/hsperfdata_root

ENV PWM_APPLICATIONPATH=/config

VOLUME [ "/config" ]
