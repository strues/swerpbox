FROM swerpbox/ubuntu-base

LABEL org.label-schema.vendor="SwerpBox: Sonarr" \
      org.label-schema.build-date="2017-03-15T00:10:00+00:00" \
      org.label-schema.name="Sonarr running on Ubuntu" \
      org.label-schema.vcs-type="git" \
      org.label-schema.vcs-url="https://github.com/strues/swerpbox" \
      maintainer="Steven Truesdell <steven@strues.io>"

ARG DEBIAN_FRONTEND="noninteractive"
ENV XDG_CONFIG_HOME="/config/xdg"

RUN \
 apt-get update && apt-get install -y dirmngr && \
 apt-key adv --keyserver keyserver.ubuntu.com --recv-keys FDA5DFFC && \
 echo "deb http://apt.sonarr.tv/ develop main" > \
  /etc/apt/sources.list.d/sonarr.list && \

# install packages
 apt-get update && \
 apt-get install -y libcurl3 nzbdrone && \

# cleanup
 apt-get clean && \
 rm -rf /tmp/*  /var/lib/apt/lists/*  /var/tmp/*

# add local files
COPY rootfs/ /

# ports and volumes
EXPOSE 8989
VOLUME /config /downloads /tv /data
