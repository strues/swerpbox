FROM swerpbox/alpine-base

LABEL org.label-schema.vendor="SwerpBox: SickRage" \
      org.label-schema.build-date="2017-01-27T00:12:00+00:00" \
      org.label-schema.name="SickRage running on Alpine 3.5" \
      org.label-schema.vcs-type="git" \
      org.label-schema.vcs-url="https://github.com/strues/swerpbox" \
      maintainer="Steven Truesdell <steven@strues.io>"

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
