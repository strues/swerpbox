FROM scratch
LABEL org.label-schema.vendor="SwerpBox" \
      org.label-schema.build-date="2017-01-29T00:10:00+00:00" \
      org.label-schema.name="minimal base images with Ubuntu" \
      org.label-schema.vcs-type="git" \
      org.label-schema.vcs-url="https://github.com/strues/swerpbox" \
      maintainer="Steven Truesdell <steven@strues.io>"

ADD files/rootfs.tar /

ADD https://github.com/just-containers/s6-overlay/releases/download/v1.19.1.1/s6-overlay-amd64.tar.gz /tmp/
RUN \
  tar xzf /tmp/s6-overlay-amd64.tar.gz -C / && \
  useradd -u 911 -U -d /config -s /bin/false swerp && \
  usermod -G users swerp && \

  mkdir -p \
    /app \
    /config \
    /data \
    /media \
    /defaults

COPY root /

ENTRYPOINT ["/init"]
