FROM swerpbox/alpine-base

LABEL org.label-schema.vendor="SwerpBox: rTorrent/ruTorrent" \
      org.label-schema.build-date="2017-02-12T00:12:00+00:00" \
      org.label-schema.name="rTorrent and ruTorrent running on Alpine 3.5" \
      org.label-schema.vcs-type="git" \
      org.label-schema.vcs-url="https://github.com/strues/swerpbox" \
      maintainer="Steven Truesdell <steven@strues.io>"

ARG BUILD_CORES
ARG MEDIAINF_VER="0.7.90"
ARG RTORRENT_VER="0.9.6"
ARG LIBTORRENT_VER="0.13.6"
ARG RUTORRENT_ADDR="https://github.com/Novik/ruTorrent/archive/master.tar.gz"
# install runtime packages
RUN \
  apk add --no-cache \
    ca-certificates \
    curl \
    fcgi \
    ffmpeg \
    geoip \
    gzip \
    dtach \
    tar \
    unrar \
    unzip \
    wget \
    irssi \
    irssi-perl \
    libressl-dev \
    zlib \
    zlib-dev \
    libxml2-dev \
    perl-archive-zip \
    perl-net-ssleay \
    perl-digest-sha1 \
    git \
    zip && \
 # php packages
  apk add --no-cache --repository http://nl.alpinelinux.org/alpine/edge/community \
    php7 \
    php7-cgi \
    php7-fpm \
    php7-json  \
    php7-mbstring \
    php7-sockets \
    php7-opcache \
    php7-mcrypt \
    php7-xmlrpc \
    php7-pear && \

# install build packages
  apk add --no-cache --virtual=build-deps \
    autoconf \
    automake \
    build-base \
    subversion \
    cppunit-dev \
    curl-dev \
    perl-dev \
    file \
    g++ \
    gcc \
    libtool \
    make \
    ncurses-dev && \

  cd /tmp && \
  git clone https://github.com/esmil/mktorrent && \
  svn checkout http://svn.code.sf.net/p/xmlrpc-c/code/stable xmlrpc-c && \
  git clone -b ${LIBTORRENT_VER} https://github.com/rakshasa/libtorrent.git && \
  git clone -b ${RTORRENT_VER} https://github.com/rakshasa/rtorrent.git && \
  cd /tmp/mktorrent && \
  make -j ${BUILD_CORES-$(grep -c "processor" /proc/cpuinfo)} && \
  make install && \
# install webui
  mkdir -p /var/www/public/rutorrent /defaults/rutorrent-conf && \
# install autodl-irssi perl modules
  perl -MCPAN -e 'my $c = "CPAN::HandleConfig"; $c->load(doit => 1, autoconfig => 1); $c->edit(prerequisites_policy => "follow"); $c->edit(build_requires_install_policy => "yes"); $c->commit' && \
  curl -L http://cpanmin.us | perl - App::cpanminus && \
	cpanm HTML::Entities XML::LibXML JSON JSON::XS && \

# compile mediainfo packages
 curl -o \
 /tmp/libmediainfo.tar.gz -L \
        "http://mediaarea.net/download/binary/libmediainfo0/${MEDIAINF_VER}/MediaInfo_DLL_${MEDIAINF_VER}_GNU_FromSource.tar.gz" && \
 curl -o \
 /tmp/mediainfo.tar.gz -L \
        "http://mediaarea.net/download/binary/mediainfo/${MEDIAINF_VER}/MediaInfo_CLI_${MEDIAINF_VER}_GNU_FromSource.tar.gz" && \

 mkdir -p /tmp/libmediainfo /tmp/mediainfo && \

 tar xf /tmp/libmediainfo.tar.gz -C \
        /tmp/libmediainfo --strip-components=1 && \

 tar xf /tmp/mediainfo.tar.gz -C \
        /tmp/mediainfo --strip-components=1 && \

 cd /tmp/libmediainfo && ./SO_Compile.sh && \

 cd /tmp/libmediainfo/ZenLib/Project/GNU/Library && \
        make -j $(getconf _NPROCESSORS_ONLN) && \
        make install && \

 cd /tmp/libmediainfo/MediaInfoLib/Project/GNU/Library && \
        make -j $(getconf _NPROCESSORS_ONLN) && \
        make install && \

 cd /tmp/mediainfo && ./CLI_Compile.sh && \
 cd /tmp/mediainfo/MediaInfo/Project/GNU/CLI && \
        make -j $(getconf _NPROCESSORS_ONLN) && \
        make install && \
  cd /tmp/xmlrpc-c && \
  ./configure && \
  make -j ${NB_CORES} && \
  make install && \
  cd /tmp/libtorrent && \
  ./autogen.sh && \
  ./configure && \
  make -j ${BUILD_CORES-$(grep -c "processor" /proc/cpuinfo)} && \
  make install && \
  cd /tmp/rtorrent && \
  ./autogen.sh && \
  ./configure --with-xmlrpc-c && \
  make -j ${BUILD_CORES-$(grep -c "processor" /proc/cpuinfo)} && \
  make install && \
# cleanup
 apk del --purge build-deps && rm -rf /tmp/*

# add local files
COPY rootfs/ /

# ports and volumes

EXPOSE 49123 5000
VOLUME ["/config", "/data", "/logs"]
