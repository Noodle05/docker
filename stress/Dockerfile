FROM arm64v8/alpine:3.8

ARG STRESS_VERSION=1.0.4
ARG SHELL=/bin/bash

RUN apk --no-cache --virtual .build-deps add g++ make curl \
 && curl -kL https://people.seas.harvard.edu/~apw/stress/stress-${STRESS_VERSION}.tar.gz \
  | tar -C /tmp -xzv \
 && cd /tmp/stress-${STRESS_VERSION} \
 && ./configure && make && make install \
 && apk del .build-deps \
 && rm -fr /tmp/*

CMD [ '/usr/local/bin/stress' ]
