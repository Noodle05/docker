FROM alpine

LABEL maintainer="Wei Gao<wei@gaofamily.org>"

ENV GITEA_STATIC_DOCKER_URL="https://github.com/Noodle05/gitea-static.git"
ENV GITEA_RSS="https://www.github.com/go-gitea/gitea/releases.atom"

ENV DOCKER_USER=""
ENV DOCKER_PASSWD=""

RUN apk add --no-cache git python3 py3-pip docker-cli \
 && pip install rsstail \
 && mkdir /work

COPY --from=docker/buildx-bin:latest /buildx "/usr/local/lib/docker/cli-plugins/docker-buildx"

ADD entrypoint "/work/entrypoint"

WORKDIR "/work"
