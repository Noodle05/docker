FROM alpine:3.4
MAINTAINER Wei Gao <wei@gaofamily.org>

ARG GLIBC_VERSION=2.23-r3
ENV JAVA_VERSION_MAJOR=8 JAVA_VERSION_MINOR=112 JAVA_VERSION_BUILD=15 JAVA_PACKAGE=jre JAVA_HOME=/opt/jre

RUN apk add --no-cache --virtual .build-deps curl ca-certificates tar && \
    curl -Ls -o /tmp/glibc-${GLIBC_VERSION}.apk "https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-2.23-r3.apk" && \
    apk add --no-cache --allow-untrusted /tmp/glibc-${GLIBC_VERSION}.apk && rm /tmp/glibc-${GLIBC_VERSION}.apk && \
    mkdir /opt && curl -jksSLH "Cookie: oraclelicense=accept-securebackup-cookie" \
          http://download.oracle.com/otn-pub/java/jdk/${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-b${JAVA_VERSION_BUILD}/${JAVA_PACKAGE}-${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-linux-x64.tar.gz \
    | tar -xzf - -C /opt && \
    ln -s /opt/jre1.${JAVA_VERSION_MAJOR}.0_${JAVA_VERSION_MINOR} /opt/jre && \
    rm -fr /opt/jre1.${JAVA_VERSION_MAJOR}.0_${JAVA_VERSION_MINOR}/bin/javaws \
           /opt/jre1.${JAVA_VERSION_MAJOR}.0_${JAVA_VERSION_MINOR}/bin/ControlPanel \
           /opt/jre1.${JAVA_VERSION_MAJOR}.0_${JAVA_VERSION_MINOR}/bin/jcontrol \
           /opt/jre1.${JAVA_VERSION_MAJOR}.0_${JAVA_VERSION_MINOR}/lib/plugin.jar \
           /opt/jre1.${JAVA_VERSION_MAJOR}.0_${JAVA_VERSION_MINOR}/lib/ext/jfxrt.jar \
           /opt/jre1.${JAVA_VERSION_MAJOR}.0_${JAVA_VERSION_MINOR}/lib/javaws.jar \
           /opt/jre1.${JAVA_VERSION_MAJOR}.0_${JAVA_VERSION_MINOR}/lib/desktop \
           /opt/jre1.${JAVA_VERSION_MAJOR}.0_${JAVA_VERSION_MINOR}/lib/deploy* \
           /opt/jre1.${JAVA_VERSION_MAJOR}.0_${JAVA_VERSION_MINOR}/lib/*javafx* \
           /opt/jre1.${JAVA_VERSION_MAJOR}.0_${JAVA_VERSION_MINOR}/lib/*jfx* \
           /opt/jre1.${JAVA_VERSION_MAJOR}.0_${JAVA_VERSION_MINOR}/lib/font* \
           /opt/jre1.${JAVA_VERSION_MAJOR}.0_${JAVA_VERSION_MINOR}/lib/oblique-fonts \
           /opt/jre1.${JAVA_VERSION_MAJOR}.0_${JAVA_VERSION_MINOR}/lib/locale \
           /opt/jre1.${JAVA_VERSION_MAJOR}.0_${JAVA_VERSION_MINOR}/lib/amd64/libavplugin-*.so \
           /opt/jre1.${JAVA_VERSION_MAJOR}.0_${JAVA_VERSION_MINOR}/lib/amd64/libdecora_sse.so \
           /opt/jre1.${JAVA_VERSION_MAJOR}.0_${JAVA_VERSION_MINOR}/lib/amd64/libprism_*.so \
           /opt/jre1.${JAVA_VERSION_MAJOR}.0_${JAVA_VERSION_MINOR}/lib/amd64/libfxplugins.so \
           /opt/jre1.${JAVA_VERSION_MAJOR}.0_${JAVA_VERSION_MINOR}/lib/amd64/libglass.so \
           /opt/jre1.${JAVA_VERSION_MAJOR}.0_${JAVA_VERSION_MINOR}/lib/amd64/libgstreamer-lite.so \
           /opt/jre1.${JAVA_VERSION_MAJOR}.0_${JAVA_VERSION_MINOR}/lib/amd64/libjavafx*.so \
           /opt/jre1.${JAVA_VERSION_MAJOR}.0_${JAVA_VERSION_MINOR}/lib/amd64/libjfx*.so \
           /opt/jre1.${JAVA_VERSION_MAJOR}.0_${JAVA_VERSION_MINOR}/lib/security/javaws.policy \
           /opt/jre1.${JAVA_VERSION_MAJOR}.0_${JAVA_VERSION_MINOR}/lib/images/icons \
           /opt/jre1.${JAVA_VERSION_MAJOR}.0_${JAVA_VERSION_MINOR}/plugin \
           /opt/jre1.${JAVA_VERSION_MAJOR}.0_${JAVA_VERSION_MINOR}/man \
           /opt/jre1.${JAVA_VERSION_MAJOR}.0_${JAVA_VERSION_MINOR}/plugin && \
    curl -jksSLH "Cookie: oraclelicense=accept-securebackup-cookie" -o /tmp/jce_policy-8.zip http://download.oracle.com/otn-pub/java/jce/8/jce_policy-8.zip && \
    unzip -d /tmp /tmp/jce_policy-8.zip && \
    cp /tmp/UnlimitedJCEPolicyJDK8/local_policy.jar /opt/jre1.${JAVA_VERSION_MAJOR}.0_${JAVA_VERSION_MINOR}/lib/security/local_policy.jar && \
    cp /tmp/UnlimitedJCEPolicyJDK8/US_export_policy.jar /opt/jre1.${JAVA_VERSION_MAJOR}.0_${JAVA_VERSION_MINOR}/lib/security/US_export_policy.jar && \
    apk del .build-deps && \
    rm -fr .build-deps && \
    rm -fr /tmp/*

ENV PATH=${PATH}:${JAVA_HOME}/bin
