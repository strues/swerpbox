FROM swerpbox/alpine-base

MAINTAINER Steven Truesdell <steven@strues.io>

ARG BUILD_DATE
ARG VERSION
LABEL build_version="SwerpBox PlexPy v:- ${VERSION} Built:- ${BUILD_DATE}"

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
