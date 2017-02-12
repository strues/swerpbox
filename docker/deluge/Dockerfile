FROM swerpbox/alpine-base

# environment variables
ENV PYTHON_EGG_CACHE="/config/plugins/.python-eggs"

LABEL org.label-schema.vendor="SwerpBox: Deluge" \
      org.label-schema.build-date="2017-01-27T00:12:00+00:00" \
      org.label-schema.name="Deluge and Deluge-WebUI running on Alpine 3.5" \
      org.label-schema.vcs-type="git" \
      org.label-schema.vcs-url="https://github.com/strues/swerpbox" \
      maintainer="Steven Truesdell <steven@strues.io>"

# install runtime packages
RUN \
  echo "@testing http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
  apk update && \
  apk add --no-cache ca-certificates p7zip unrar unzip && \

  apk add --no-cache deluge@testing py2-pip && \

# install pip packages

 pip install service_identity && \
 mkdir -p /config/plugins /logs/deluge && \

# cleanup
 apk del --purge py2-pip && \
 rm -rf /root/.cache && \
 rm -rf /var/cache/apk/*

# add local files
COPY rootfs/ /

# ports and volumes
EXPOSE 8112 58846 58946 58946/udp
VOLUME ["/config", "/data", "/logs"]
