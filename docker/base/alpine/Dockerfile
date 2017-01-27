FROM alpine:3.5
MAINTAINER Steven Truesdell <steven@strues.io>

# set version for s6 overlay
ARG OVERLAY_VERSION="v1.18.1.5"
ARG OVERLAY_ARCH="amd64"
LABEL org.label-schema.vendor="SwerpBox: Alpine Base" \
      org.label-schema.build-date="2017-01-27T00:12:00+00:00" \
      org.label-schema.name="Alpine 3.5 base image for Swerpbox" \
      org.label-schema.vcs-type="git" \
      org.label-schema.vcs-url="https://github.com/strues/swerpbox"

# environment variables
ENV PS1="$(whoami)@$(hostname):$(pwd)$ " \
HOME="/root" \
TERM="xterm"

RUN \
 apk update && \
 apk add --no-cache --virtual=build-deps curl tar && \
 apk add --no-cache bash ca-certificates coreutils shadow tzdata && \

 curl -o /tmp/s6-overlay.tar.gz -L \
	"https://github.com/just-containers/s6-overlay/releases/download/${OVERLAY_VERSION}/s6-overlay-${OVERLAY_ARCH}.tar.gz" && \
 tar xfz /tmp/s6-overlay.tar.gz -C / && \

 groupmod -g 1000 users && \
 useradd -u 911 -U -d /config -s /bin/false swerp && \
 usermod -G users swerp && \

 mkdir -p \
	/app \
	/config \
	/web \
	/data \
	/media \
    /logs \
	/defaults && \

 apk del --purge build-deps && \
 rm -rf /tmp/*

COPY rootfs/ /

ENTRYPOINT ["/init"]
