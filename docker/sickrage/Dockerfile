FROM swerpbox/alpine-base

MAINTAINER Steven Truesdell <steven@strues.io>

LABEL build_version="SwerpBox SickRage"
ARG SICK_REPO="https://github.com/SickRage/SickRage.git"
ENV TERM="xterm"

RUN \
  apk -U upgrade && \
  apk add --no-cache --virtual=build-deps make gcc g++ python-dev py2-pip libressl-dev libffi-dev && \

  apk add --no-cache --virtual=run-deps ca-certificates unrar git python py-libxml2 py-lxml && \

  pip --no-cache-dir install pyopenssl cheetah requirements && \
  git clone --depth 2 ${SICK_REPO} /app/sickrage && \

  # cleanup
  apk del --no-cache --purge build-deps && \
  
  rm -rf /tmp/* /var/cache/apk/* /var/tmp/*

# s6 scripts
COPY rootfs/ /

# ports and volumes
VOLUME ["/config", "/logs", "/data", "/media"]
EXPOSE 8081
