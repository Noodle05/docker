FROM alpine:latest
MAINTAINER Wei Gao <wei@gaofamily.org>

ENV JAVA_VERSION_MAJOR=8 JAVA_VERSION_MINOR=60 JAVA_VERSION_BUILD=27 JAVA_PACKAGE=jre JAVA_HOME=/opt/jre

RUN apk add --update curl ca-certificates tar && \
    curl -Ls "https://circle-artifacts.com/gh/andyshinn/alpine-pkg-glibc/6/artifacts/0/home/ubuntu/alpine-pkg-glibc/packages/x86_64/glibc-2.21-r2.apk" >/tmp/glibc-2.21-r2.apk && \
    apk add --allow-untrusted /tmp/glibc-2.21-r2.apk && rm /tmp/glibc-2.21-r2.apk && \
    /usr/glibc/usr/bin/ldconfig /lib /usr/glibc/usr/lib && \
    mkdir /opt && curl -jksSLH "Cookie: oraclelicense=accept-securebackup-cookie" \
          http://download.oracle.com/otn-pub/java/jdk/${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-b${JAVA_VERSION_BUILD}/${JAVA_PACKAGE}-${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-linux-x64.tar.gz \
    | tar -xzf - -C /opt && \
    ln -s /opt/jre1.${JAVA_VERSION_MAJOR}.0_${JAVA_VERSION_MINOR} /opt/jre && \
    rm -fr /opt/jre/bin/javaws \
           /opt/jre/bin/ControlPanel \
           /opt/jre/bin/jcontrol \
           /opt/jre/lib/plugin.jar \
           /opt/jre/lib/ext/jfxrt.jar \
           /opt/jre/lib/javaws.jar \
           /opt/jre/lib/desktop \
           /opt/jre/lib/deploy* \
           /opt/jre/lib/*javafx* \
           /opt/jre/lib/*jfx* \
           /opt/jre/lib/locale \
           /opt/jre/lib/amd64/libavplugin-*.so \
           /opt/jre/lib/amd64/libdecora_sse.so \
           /opt/jre/lib/amd64/libprism_*.so \
           /opt/jre/lib/amd64/libfxplugins.so \
           /opt/jre/lib/amd64/libglass.so \
           /opt/jre/lib/amd64/libgstreamer-lite.so \
           /opt/jre/lib/amd64/libjavafx*.so \
           /opt/jre/lib/amd64/libjfx*.so \
           /opt/jre/lib/ext/jaccess.jar \
           /opt/jre/lib/security/javaws.policy \
           /opt/jre/lib/images/icons \
           /opt/jre/man \
           /opt/jre/plugin && \
    curl -jksSLH "Cookie: oraclelicense=accept-securebackup-cookie" -o /tmp/jce_policy-8.zip http://download.oracle.com/otn-pub/java/jce/8/jce_policy-8.zip && \
    unzip -d /tmp /tmp/jce_policy-8.zip && \
    cp /tmp/UnlimitedJCEPolicyJDK8/local_policy.jar /opt/jre1.${JAVA_VERSION_MAJOR}.0_${JAVA_VERSION_MINOR}/lib/security/local_policy.jar && \
    cp /tmp/UnlimitedJCEPolicyJDK8/US_export_policy.jar /opt/jre1.${JAVA_VERSION_MAJOR}.0_${JAVA_VERSION_MINOR}/lib/security/US_export_policy.jar && \
    apk del curl ca-certificates tar && \
    rm -fr /tmp/* && \
    rm /var/cache/apk/*

ENV PATH=${PATH}:${JAVA_HOME}/bin
