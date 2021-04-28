FROM --platform=${TARGETPLATFORM} alpine:3.13
LABEL maintainer "Wei Gao <wei@gaofamily.org>"

# Install packages
RUN apk --no-cache --no-progress add bash minidlna tini

# Entrypoint
COPY entrypoint.sh /
ENTRYPOINT ["/sbin/tini", "--", "/entrypoint.sh"]

VOLUME [ "/var/lib/minidlna" ]
