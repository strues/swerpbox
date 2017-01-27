FROM swerpbox/alpine-base

MAINTAINER Steven Truesdell <steven@strues.io>

# environment variables
ENV PYTHON_EGG_CACHE="/config/plugins/.python-eggs"

LABEL org.label-schema.vendor="SwerpBox: Deluge" \
      org.label-schema.build-date="2017-01-27T00:12:00+00:00" \
      org.label-schema.name="Deluge and Deluge-WebUI running on Alpine 3.5" \
      org.label-schema.vcs-type="git" \
      org.label-schema.vcs-url="https://github.com/strues/swerpbox"

# install runtime packages
RUN \
  apk update && \
  apk add --no-cache ca-certificates libressl2.4-libssl p7zip unrar unzip && \
  apk add --no-cache --repository http://nl.alpinelinux.org/alpine/edge/testing deluge && \

# install build packages
 apk add --no-cache --virtual=build-dependencies g++ gcc libffi-dev libressl-dev py2-pip python2-dev && \

# install pip packages
 pip install --no-cache-dir -U incremental pip && \
 pip install --no-cache-dir -U crypto mako markupsafe pyopenssl service_identity six twisted zope.interface && \
 mkdir -p /config/plugins /logs/deluge && \


# cleanup
 apk del --purge build-dependencies && rm -rf /root/.cache

# add local files
COPY rootfs/ /

# ports and volumes
EXPOSE 8112 58846 58946 58946/udp
VOLUME ["/config", "/data", "/logs"]
