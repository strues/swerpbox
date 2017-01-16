FROM swerpbox/php

MAINTAINER Steven Truesdell <steven@strues.io>

ENV MEDIAINFO_VER="0.7.90" \
    RTORRENT_VER="0.9.6" \
    LIBTORRENT_VER="0.13.6"

RUN \
  apk add --no-cache  \
    	--repository http://nl.alpinelinux.org/alpine/edge/main\
      perl \
      irssi irssi-perl libxml2-dev perl-dev perl-archive-zip perl-net-ssleay perl-digest-sha1 perl-json perl-html-parser

    RUN apk add --no-cache \
    	--repository http://nl.alpinelinux.org/alpine/edge/community \
    	perl-xml-libxml

    RUN apk add --no-cache --repository http://nl.alpinelinux.org/alpine/edge/testing perl-json-xs
RUN \
  build_pkgs="build-base libtool zlib-dev libxml2-dev perl-dev automake autoconf wget subversion cppunit-dev ncurses-dev curl-dev" && \
  runtime_pkgs="ffmpeg dtach git zlib ca-certificates curl gzip tar unzip zip unrar geoip" && \
  apk add --no-cache --repository http://nl.alpinelinux.org/alpine/edge/community ${build_pkgs} ${runtime_pkgs} && \
  mkdir -p  /defaults/rutorrent-conf && \
  cd /tmp \
  && git clone https://github.com/esmil/mktorrent \
  && svn checkout http://svn.code.sf.net/p/xmlrpc-c/code/stable xmlrpc-c \
  && git clone https://github.com/rakshasa/libtorrent.git \
  && git clone https://github.com/rakshasa/rtorrent.git \
  && wget http://mediaarea.net/download/binary/mediainfo/${MEDIAINFO_VER}/MediaInfo_CLI_${MEDIAINFO_VER}_GNU_FromSource.tar.gz \
  && wget http://mediaarea.net/download/binary/libmediainfo0/${MEDIAINFO_VER}/MediaInfo_DLL_${MEDIAINFO_VER}_GNU_FromSource.tar.gz \
  && tar xzf MediaInfo_DLL_${MEDIAINFO_VER}_GNU_FromSource.tar.gz \
  && tar xzf MediaInfo_CLI_${MEDIAINFO_VER}_GNU_FromSource.tar.gz \
  && cd /tmp/mktorrent \
  && make -j $(getconf _NPROCESSORS_ONLN) \
  && make install \
  && cd  /tmp/MediaInfo_DLL_GNU_FromSource \
  && ./SO_Compile.sh \
  && cd /tmp/MediaInfo_DLL_GNU_FromSource/ZenLib/Project/GNU/Library \
  && make -j $(getconf _NPROCESSORS_ONLN) \
  && make install \
  && cd /tmp/MediaInfo_DLL_GNU_FromSource/MediaInfoLib/Project/GNU/Library \
  && make -j $(getconf _NPROCESSORS_ONLN) \
  && make install \
  && cd /tmp/MediaInfo_CLI_GNU_FromSource \
  && ./CLI_Compile.sh \
  && cd /tmp/MediaInfo_CLI_GNU_FromSource/MediaInfo/Project/GNU/CLI \
  && make -j $(getconf _NPROCESSORS_ONLN) \
  && make install

  RUN \
  cd /tmp/xmlrpc-c \
  && ./configure --prefix=/usr --disable-cplusplus \
  && make -j $(getconf _NPROCESSORS_ONLN) \
  && make install \
  && cd /tmp/libtorrent \
  && git checkout ${LIBTORRENT_VER} \
  && ./autogen.sh \
  && ./configure --prefix=/usr \
  && make -j $(getconf _NPROCESSORS_ONLN) \
  && make install \
  && cd /tmp/rtorrent \
  && git checkout ${RTORRENT_VER} \
  && ./autogen.sh \
  && ./configure --prefix=/usr --with-xmlrpc-c \
  && make -j $(getconf _NPROCESSORS_ONLN) \
  && make install && \
  # install autodl-irssi perl modules
 perl -MCPAN -e 'my $c = "CPAN::HandleConfig"; $c->load(doit => 1, autoconfig => 1); $c->edit(prerequisites_policy => "follow"); $c->edit(build_requires_install_policy => "yes"); $c->commit' && \
 curl -L http://cpanmin.us | perl - App::cpanminus && \
	cpanm HTML::Entities XML::LibXML JSON JSON::XS && \
  apk del ${build_pkgs} && \
  rm -rf /tmp/* && \
  deluser svn && \
  delgroup svnusers && \
  echo "export TERM=xterm" >> /etc/profile



COPY root /

EXPOSE 5000 6881 49123
VOLUME /config /data /media /web
