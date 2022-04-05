FROM node:lts-alpine AS builder

ARG GITEA_VERSION=1.16.5
ARG GITEA_GIT_URL=https://github.com/go-gitea/gitea.git

RUN apk --no-cache add git make \
 && mkdir /work \
 && cd /work \
 && git clone https://github.com/go-gitea/gitea.git \
 && cd gitea \
 && git checkout tags/v${GITEA_VERSION} \
 && make frontend

FROM alpine:latest

LABEL maintainer='Wei Gao<wei@gaofamily.org>'

COPY --from=builder /work/gitea/public /gitea/static

VOLUME /gitea-static

CMD [ "cp", "-R", "/gitea/static", "/gitea-static" ]
