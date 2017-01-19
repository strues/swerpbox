FROM swerpbox/alpine-base

MAINTAINER Steven Truesdell <steven@strues.io>

ARG RESILIO_LOC="https://download-cdn.resilio.com/stable/linux-x64/resilio-sync_x64.tar.gz"

RUN \
  apk --update upgrade && \
  apk add curl tar ca-certificates libc6-compat && \
  mkdir -p /lib64 /defaults && \
  ln /lib/ld-linux-x86-64.so.2 /lib64/ld-linux-x86-64.so.2 && \

  curl -o /tmp/sync.tar.gz -L ${RESILIO_LOC} && \
  tar xf /tmp/sync.tar.gz -C /usr/bin && \
  rm -rf /tmp/*

VOLUME ["/config", "/data", "/media"]

COPY /rootfs /
COPY sync.conf /defaults

EXPOSE 8888 55555
