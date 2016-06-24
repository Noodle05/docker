FROM jetty:9-jre8-alpine
MAINTAINER Wei Gao<wei@gaofamily.org>

RUN java -jar "$JETTY_HOME/start.jar" --add-to-startd=http-forwarded && \
    apk add --no-cache --virtual .build-deps curl fastjar && \
    mkdir $JETTY_BASE/webapps/ROOT/ && \
    curl -o /root/pwm-bundle.zip -L "http://www.pwm-project.org/artifacts/pwm/pwm-1.8.0-SNAPSHOT-2016-06-02T15%3A59%3A59Z-pwm-bundle.zip" && \
    unzip -d /root /root/pwm-bundle.zip && \
    cd $JETTY_BASE/webapps/ROOT/ && \
    fastjar -xf /root/pwm.war && \
    rm -fr /root/* && \
    mv $JETTY_BASE/webapps/ROOT/WEB-INF/log4jconfig-sample.xml $JETTY_BASE/webapps/ROOT/WEB-INF/log4jconfig.xml && \
    curl -o $JETTY_BASE/webapps/ROOT/WEB-INF/lib/postgresql-9.4-1208.jar -L "https://jdbc.postgresql.org/download/postgresql-9.4.1208.jar" && \
    sed -i 's/^# jetty.deploy.scanInterval=1$/jetty.deploy.scanInterval=0/g' $JETTY_BASE/start.d/deploy.ini && \
    sed -i 's/^# \(jetty.httpConfig.forwarded.*\)$/\1/g' $JETTY_BASE/start.d/http-forwarded.ini && \
    apk del .build-deps && \
    rm -fr .bulid-deps && \
    rm -fr /tmp/hsperfdata_root

ENV PWM_APPLICATIONPATH=/config

VOLUME [ "/config" ]
