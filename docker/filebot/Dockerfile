FROM swerpbox/ubuntu:16.04
MAINTAINER Steven Truesdell <steven@strues.io>

ARG BUILD_DATE
ARG VERSION
LABEL build_version="SwerpBox Filebot v:- ${VERSION} Built:- ${BUILD_DATE}"

ENV DEBIAN_FRONTEND noninteractive
ENV TERM=xterm

RUN \
  echo "force-unsafe-io" > /etc/dpkg/dpkg.cfg.d/02apt-speedup && \
  echo "Acquire::http {No-Cache=True;};" > /etc/apt/apt.conf.d/no-cache && \
  apt-get -q update && \
  echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections && \
  apt-get --no-install-recommends -qqy install software-properties-common curl wget && \
  add-apt-repository ppa:webupd8team/java && \
  apt-get update && \
  apt-get install -qqy --allow-unauthenticated oracle-java8-installer inotify-tools && \
  mkdir /app/ && mkdir -p /logs/filebot

COPY app/ /app/

RUN \
  dpkg -i /app/filebot_4.7.7_amd64.deb && rm /app/filebot_4.7.7_amd64.deb && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
  mkdir /config


COPY rootfs /

RUN \
  chmod a+wx /app/filebot.sh && \
  chmod +x /app/monitor.sh && \
  chmod a+w /app/filebot.conf

VOLUME ["/data", "/media", "/config", "/logs"]
