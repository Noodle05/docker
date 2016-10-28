FROM alpine:3.4
MAINTAINER Wei Gao <wei@gaofamily.org>

ARG GLIBC_VERSION=2.23-r3
ARG JAVA_VERSION_MAJOR=8
ARG JAVA_VERSION_MINOR=112
ARG JAVA_VERSION_BUILD=15
ARG JAVA_PACKAGE=jre
ARG JAVA_PATH_ROOT=/usr/lib/jvm
ARG JAVA_PATH=/usr/lib/jvm/jre1.${JAVA_VERSION_MAJOR}.0_${JAVA_VERSION_MINOR}

ENV JAVA_HOME=/usr/lib/jvm/default-jvm

RUN apk add --no-cache --virtual .build-deps curl ca-certificates tar && \
    curl -Ls -o /tmp/glibc-${GLIBC_VERSION}.apk "https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-2.23-r3.apk" && \
    apk add --no-cache --allow-untrusted /tmp/glibc-${GLIBC_VERSION}.apk && rm /tmp/glibc-${GLIBC_VERSION}.apk && \
    mkdir -p ${JAVA_PATH_ROOT} && \
    curl -jksSLH "Cookie: oraclelicense=accept-securebackup-cookie" \
          http://download.oracle.com/otn-pub/java/jdk/${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-b${JAVA_VERSION_BUILD}/${JAVA_PACKAGE}-${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-linux-x64.tar.gz \
    | tar -xzf - -C ${JAVA_PATH_ROOT} && \
    ln -s ${JAVA_PATH} ${JAVA_HOME} && \
    rm -fr ${JAVA_PATH}/bin/javaws \
           ${JAVA_PATH}/bin/ControlPanel \
           ${JAVA_PATH}/bin/jcontrol \
           ${JAVA_PATH}/lib/plugin.jar \
           ${JAVA_PATH}/lib/ext/jfxrt.jar \
           ${JAVA_PATH}/lib/javaws.jar \
           ${JAVA_PATH}/lib/desktop \
           ${JAVA_PATH}/lib/deploy* \
           ${JAVA_PATH}/lib/*javafx* \
           ${JAVA_PATH}/lib/*jfx* \
           ${JAVA_PATH}/lib/font* \
           ${JAVA_PATH}/lib/oblique-fonts \
           ${JAVA_PATH}/lib/locale \
           ${JAVA_PATH}/lib/amd64/libavplugin-*.so \
           ${JAVA_PATH}/lib/amd64/libdecora_sse.so \
           ${JAVA_PATH}/lib/amd64/libprism_*.so \
           ${JAVA_PATH}/lib/amd64/libfxplugins.so \
           ${JAVA_PATH}/lib/amd64/libglass.so \
           ${JAVA_PATH}/lib/amd64/libgstreamer-lite.so \
           ${JAVA_PATH}/lib/amd64/libjavafx*.so \
           ${JAVA_PATH}/lib/amd64/libjfx*.so \
           ${JAVA_PATH}/lib/security/javaws.policy \
           ${JAVA_PATH}/lib/images/icons \
           ${JAVA_PATH}/plugin \
           ${JAVA_PATH}/man \
           ${JAVA_PATH}/plugin && \
    curl -jksSLH "Cookie: oraclelicense=accept-securebackup-cookie" -o /tmp/jce_policy-8.zip http://download.oracle.com/otn-pub/java/jce/8/jce_policy-8.zip && \
    unzip -d /tmp /tmp/jce_policy-8.zip && \
    cp /tmp/UnlimitedJCEPolicyJDK8/local_policy.jar ${JAVA_PATH}/lib/security/local_policy.jar && \
    cp /tmp/UnlimitedJCEPolicyJDK8/US_export_policy.jar ${JAVA_PATH}/lib/security/US_export_policy.jar && \
    apk del .build-deps && \
    ln -snf ${JAVA_HOME}/bin/java /usr/bin/java && \
    ln -snf ${JAVA_HOME}/bin/keytool /usr/bin/keytool && \
    ln -snf ${JAVA_HOME}/bin/rmiregistry /usr/bin/rmiregistry && \
    rm -fr .build-deps && \
    rm -fr /tmp/*

ENTRYPOINT [ "/usr/bin/java" ]
CMD [ "-version" ]
