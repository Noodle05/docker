FROM weigao/java8
MAINTAINER Wei Gao<wei@gaofamily.org>

ENV JETTY_HOME /usr/local/jetty
RUN mkdir -p "$JETTY_HOME"
WORKDIR $JETTY_HOME

COPY docker-entrypoint.sh /

ENV JETTY_VERSION 9.3.3.v20150827
ENV JETTY_TGZ_URL https://repo1.maven.org/maven2/org/eclipse/jetty/jetty-distribution/$JETTY_VERSION/jetty-distribution-$JETTY_VERSION.tar.gz

RUN apk --update add curl tar \
    && curl -SL "$JETTY_TGZ_URL" -o jetty.tar.gz \
    && curl -SL "$JETTY_TGZ_URL.asc" -o jetty.tar.gz.asc \
    && tar -xvf jetty.tar.gz --strip-components=1 \
    && sed -i '/jetty-logging/d' etc/jetty.conf \
    && rm -fr demo-base javadoc \
    && rm jetty.tar.gz* \
    && chmod +x /docker-entrypoint.sh \
    && apk del curl tar \
    && rm /var/cache/apk/* \
    && echo 'files mdns4_minimal [NOTFOUND=return] dns mdns4' >> /etc/nsswitch.conf

ENV JETTY_BASE /var/lib/jetty
RUN mkdir -p "$JETTY_BASE"
WORKDIR $JETTY_BASE

ENV JETTY_RUN /run/jetty
ENV JETTY_STATE $JETTY_RUN/jetty.state
ENV TMPDIR /tmp/jetty

# Get the list of modules in the default start.ini and build new base with those modules, then add setuid
RUN apk --update add coreutils \
    && modules="$(grep -- ^--module= "$JETTY_HOME/start.ini" | cut -d= -f2 | paste -d, -s)" \
    && set -xe \
    && java -jar "$JETTY_HOME/start.jar" --add-to-startd="$modules,setuid" \
    && mkdir -p "$JETTY_RUN" "$TMPDIR" \
    && apk del coreutils \
    && rm /var/cache/apk/* \
    && sed -i '/\s*<!-- Uncomment to enable handling of X-Forwarded- style headers/ {N; N; N; N; /<!-- Uncomment to enable handling of X-Forwarded- style headers.*-->/ { s/<!-- Uncomment to enable handling of X-Forwarded- style headers\(.*\)-->/\1/; P; D; }}' $JETTY_HOME/etc/jetty.xml

VOLUME [ "/run/jetty", "/tmp/jetty" ]

EXPOSE 8080
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["java","-Djava.io.tmpdir=/tmp/jetty","-jar","/usr/local/jetty/start.jar","--exec-properties=/run/jetty/start.properties"]

ENV PATH=$JETTY_HOME/bin:$PATH
