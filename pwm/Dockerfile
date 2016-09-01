FROM jetty:9-jre8-alpine
MAINTAINER Wei Gao<wei@gaofamily.org>

ARG PSQL_JDBC_VERSION=9.4.1209
ARG MYSQL_JDBC_VERSION=5.1.39

RUN java -jar "$JETTY_HOME/start.jar" --add-to-startd=http-forwarded \
 && apk add --no-cache --virtual .build-deps curl fastjar tar \
 && mkdir $JETTY_BASE/webapps/ROOT/ \
 && cd /root \
 && curl -L "http://www.pwm-project.org/artifacts/pwm/pwm-1.8.0-SNAPSHOT-2016-08-28T22%3A16%3A03Z-pwm-bundle.zip" \
  | fastjar -xf /dev/stdin \
 && cd $JETTY_BASE/webapps/ROOT/ \
 && fastjar -xf /root/pwm.war \
 && mv $JETTY_BASE/webapps/ROOT/WEB-INF/log4jconfig-sample.xml $JETTY_BASE/webapps/ROOT/WEB-INF/log4jconfig.xml \
 && curl -o $JETTY_BASE/webapps/ROOT/WEB-INF/lib/postgresql.jar -L "https://jdbc.postgresql.org/download/postgresql-$PSQL_JDBC_VERSION.jar" \
 && curl -L "https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-$MYSQL_JDBC_VERSION.tar.gz" | tar -C /root -zxf - \
 && mv /root/mysql-connector-java-$MYSQL_JDBC_VERSION/mysql-connector-java-$MYSQL_JDBC_VERSION-bin.jar $JETTY_BASE/webapps/ROOT/WEB-INF/lib/mysql-connector-java.jar \
 && rm -fr /root/* \
 && sed -i 's/^# jetty.deploy.scanInterval=1$/jetty.deploy.scanInterval=0/g' $JETTY_BASE/start.d/deploy.ini \
 && sed -i 's/^# \(jetty.httpConfig.forwarded.*\)$/\1/g' $JETTY_BASE/start.d/http-forwarded.ini \
 && apk del .build-deps \
 && rm -fr .bulid-deps \
 && rm -fr /tmp/hsperfdata_root

ENV PWM_APPLICATIONPATH=/config

VOLUME [ "/config" ]
