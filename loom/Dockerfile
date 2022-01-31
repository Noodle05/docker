FROM debian:bullseye-slim

ARG JAVA_MAJOR_VERSION=19
ARG JAVA_DOWNLOAD_URL_X64="https://download.java.net/java/early_access/loom/2/openjdk-19-loom+2-58_linux-x64_bin.tar.gz"
ARG JAVA_SHA256_X64="9db8b8bc0612bc43fb6bfdeb05519a3fb412e615fa669eb09adf928dcb20e69e"
ARG JAVA_DOWNLOAD_URL_ARM64="https://download.java.net/java/early_access/loom/2/openjdk-19-loom+2-58_linux-aarch64_bin.tar.gz"
ARG JAVA_SHA256_ARM64="084110cdeaf3d47e717273a5325cbffa4592d0a610b9d48c5584dffef73133a2"

ENV LANG=en_US.UTF-8 LANGUAGE=en_US:en LC_ALL=en_US.UTF-8
ENV JAVA_HOME=/usr/local/openjdk-19
ENV PATH=/usr/local/openjdk-19/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ENV JAVA_VERSION=19-loom+2-58

RUN apt-get update \
 && apt-get install -y --no-install-recommends tzdata curl ca-certificates fontconfig locales p11-kit \
 && echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
 && locale-gen en_US.UTF-8 \
 && rm -fr /var/lib/apt/lists/* \
 && echo '#/bin/sh' > /usr/local/bin/docker-java-home \
 && echo 'echo "$JAVA_HOME"' >> /usr/local/bin/docker-java-home \
 && chmod +x /usr/local/bin/docker-java-home \
 && set -eux \
 && arch="$(dpkg --print-architecture)" \
 && case "$arch" in \
        amd64 | i386:x86-64) \
                downloadUrl="${JAVA_DOWNLOAD_URL_X64}"; \
                downloadSha256="${JAVA_SHA256_X64}"; \
                ;; \
        aarch64 | arm64) \
                downloadUrl="${JAVA_DOWNLOAD_URL_ARM64}"; \
                downloadSha256="${JAVA_SHA256_ARM64}"; \
                ;; \
        *) \
                echo >&2 "error: unsupported architecture: '$arch'"; \
                exit 1; \
                ;; \
    esac \
 && savedAptMark="$(apt-mark showmanual)" \
 && curl -o openjdk.tgz -L "$downloadUrl" \
 && echo "$downloadSha256 *openjdk.tgz" | sha256sum --strict --check - \
 && mkdir -p "$JAVA_HOME" \
 && tar --extract --file openjdk.tgz --directory "$JAVA_HOME" --strip-components 1 --no-same-owner \
 && rm openjdk.tgz \
 && apt-mark auto '.*' > /dev/null \
 && [ -z "$savedAptMark" ] || apt-mark manual $savedAptMark > /dev/null \
 && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
 && echo '#!/usr/bin/env bash' >> /etc/ca-certificates/update.d/docker-openjdk \
 && echo 'set -Eeuo pipefail' >> /etc/ca-certificates/update.d/docker-openjdk \
 && echo 'if ! [ -d "$JAVA_HOME" ]; then echo >&2 "error: missing JAVA_HOME environment variable"; exit 1; fi' >> /etc/ca-certificates/update.d/docker-openjdk \
 && echo 'cacertsFile='  >> /etc/ca-certificates/update.d/docker-openjdk \
 && echo 'for f in "$JAVA_HOME/lib/security/cacerts" "$JAVA_HOME/jre/lib/security/cacerts"; do if [ -e "$f" ]; then cacertsFile="$f"; break; fi; done' >> /etc/ca-certificates/update.d/docker-openjdk \
 && echo 'if [ -z "$cacertsFile" ] || ! [ -f "$cacertsFile" ]; then echo >&2 "error: failed to find cacerts file in $JAVA_HOME"; exit 1; fi' >> /etc/ca-certificates/update.d/docker-openjdk \
 && echo 'trust extract --overwrite --format=java-cacerts --filter=ca-anchors --purpose=server-auth "$cacertsFile"' >> /etc/ca-certificates/update.d/docker-openjdk \
 && chmod +x /etc/ca-certificates/update.d/docker-openjdk \
 && /etc/ca-certificates/update.d/docker-openjdk \
 && find "$JAVA_HOME/lib" -name '*.so' -exec dirname '{}' ';' | sort -u > /etc/ld.so.conf.d/docker-openjdk.conf \
 && ldconfig

# && java -Xshare:dump \
# && fileEncoding="$(echo 'System.out.println(System.getProperty("file.encoding"))' | jshell -s -)" \
# && [ "$fileEncoding" = 'UTF-8' ] \
# && rm -rf ~/.java \
# && javac --version \
# && java --version

CMD ["jshell"]
