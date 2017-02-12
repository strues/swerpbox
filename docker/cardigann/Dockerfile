FROM swerpbox/alpine-base

ARG GOPATH=/tmp/golang
ARG CARDIGANN_DIR=$GOPATH/src/github.com/cardigann/cardigann

ENV CONFIG_DIR=/config \
    TERM=xterm

LABEL org.label-schema.vendor="SwerpBox: Cardigann" \
      org.label-schema.build-date="2017-01-29T00:12:00+00:00" \
      org.label-schema.name="Cardigann running on Alpine 3.5" \
      org.label-schema.vcs-type="git" \
      org.label-schema.vcs-url="https://github.com/strues/swerpbox" \
      maintainer="Steven Truesdell <steven@strues.io>"

# install build packages
RUN \
  apk update && \
  apk add --no-cache --virtual=build-deps g++ gcc git make && \
  apk add --no-cache --virtual=build-deps2 --repository http://nl.alpinelinux.org/alpine/edge/community go && \
  apk add --no-cache ca-certificates && \

  git clone https://github.com/cardigann/cardigann.git "${CARDIGANN_DIR}" && \
  git -C $CARDIGANN_DIR checkout $(git -C $CARDIGANN_DIR describe --tags --candidates=1 --abbrev=0) && \
  make --debug --directory=$CARDIGANN_DIR install && \
  install -Dm755 $GOPATH/bin/cardigann /usr/bin/cardigann && \

  apk del --purge build-deps build-deps2 && \
  rm -rf /tmp/*

COPY rootfs/ /

EXPOSE 5060
VOLUME ["/config"]
