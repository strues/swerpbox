FROM swerpbox/base

MAINTAINER Steven Truesdell <steven@strues.io>

ARG BUILD_DATE
ARG VERSION
ARG RUTORRENT_ADDR="https://github.com/Novik/ruTorrent/archive/master.tar.gz"
LABEL build_version="SwerpBox v:- ${VERSION} Built:- ${BUILD_DATE}"

ARG MEDIAINF_VER="0.7.90"

# install runtime packages
RUN \
 apk add --no-cache \
        ca-certificates \
        curl \
        fcgi \
        ffmpeg \
        geoip \
        gzip \
        logrotate \
        nginx \
        rtorrent \
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
        cppunit-dev \
        curl-dev \
	      perl-dev \
        file \
        g++ \
        gcc \
        libtool \
        make \
        ncurses-dev && \

# install webui
 mkdir -p /web/rutorrent /defaults/rutorrent-conf && \
 curl -o /tmp/rutorrent.tar.gz -L ${RUTORRENT_ADDR} && \

 tar xf /tmp/rutorrent.tar.gz -C /web/rutorrent --strip-components=1 && \

 mv /web/rutorrent/conf/* /defaults/rutorrent-conf/ && \
 rm -rf /defaults/rutorrent-conf/users && \

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

# cleanup
 apk del --purge build-deps && \
 rm -rf /tmp/*

# add local files
COPY root/ /

# ports and volumes
EXPOSE 443
VOLUME /config /data /media
