FROM weigao/jetty
MAINTAINER Wei Gao<wei@gaofamily.org>

RUN apk --update add curl \
    && mkdir -p /tmp/pwm \
    && curl -SL "https://googledrive.com/host/0B3oHdiTrftrGV3ZrMi1LUzVCY1U/pwm_v1.7.1.zip" -o /tmp/pwm/pwm_v1.7.1.zip \
    && unzip -d /tmp/pwm /tmp/pwm/pwm_v1.7.1.zip && rm -f /tmp/pwm/pwm_v1.7.1.zip \
    && apk del curl \
    && rm /var/cache/apk/* \
    && mkdir -p /var/lib/jetty/webapps/ROOT \
    && unzip -d /var/lib/jetty/webapps/ROOT /tmp/pwm/pwm.war \
    && rm -fr /tmp/pwm/* \
    && mkdir -p /var/lib/pwm/config \
    && mkdir -p /var/lib/pwm/LocalDB \
    && mkdir -p /var/lib/pwm/logs \
    && chown -R jetty:jetty /var/lib/pwm \
    && sed -i 's/<param-value>PwmConfiguration.xml<\/param-value>/<param-value>\/var\/lib\/pwm\/config\/PwmConfiguration.xml<\/param-value>/g' /var/lib/jetty/webapps/ROOT/WEB-INF/web.xml \
    && ln -snf /var/lib/pwm/LocalDB /var/lib/jetty/webapps/ROOT/WEB-INF \
    && ln -snf /var/lib/pwm/logs /var/lib/jetty/webapps/ROOT/WEB-INF

VOLUME [ "/var/lib/pwm" ]
