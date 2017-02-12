FROM swerpbox/alpine-base

LABEL org.label-schema.vendor="SwerpBox: PlexPy" \
      org.label-schema.build-date="2017-01-27T00:12:00+00:00" \
      org.label-schema.name="PlexPy running on Alpine 3.5" \
      org.label-schema.vcs-type="git" \
      org.label-schema.vcs-url="https://github.com/strues/swerpbox" \
      maintainer="Steven Truesdell <steven@strues.io>"
RUN \
  apk --update add --no-cache curl freetype git lcms2 libjpeg-turbo libwebp \
  openjpeg p7zip py-lxml python py2-pip tar tiff unrar unzip wget xz zlib && \

  apk add --no-cache --repository http://nl.alpinelinux.org/alpine/edge/community vnstat && \

  # install build packages
  apk add --no-cache --virtual=build-deps \
    autoconf \
    automake \
    freetype-dev \
    g++ \
    gcc \
    jpeg-dev \
    lcms2-dev \
    libffi-dev \
    libpng-dev \
    libwebp-dev \
    linux-headers \
    make \
    openjpeg-dev \
    openssl-dev \
    python-dev \
    tiff-dev \
    zlib-dev && \

  # add pip packages
  pip install --no-cache-dir -U pip && \
  LIBRARY_PATH=/lib:/usr/lib \

  pip install --no-cache-dir -U \
    cheetah \
    configparser \
    ndg-httpsclient \
    notify \
    paramiko \
    pillow \
    psutil \
    pyopenssl \
    requests \
    setuptools \
    urllib3 \
    virtualenv && \

  # clean up
  apk del --purge build-deps && \
  rm -rf /root/.cache /tmp/*

COPY rootfs/ /

# ports and volumes
VOLUME ["/config", "/logs"]
EXPOSE 8181
