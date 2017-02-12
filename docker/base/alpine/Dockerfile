FROM alpine:3.5


ARG OVERLAY_VERSION="v1.19.1.1"
LABEL org.label-schema.vendor="SwerpBox: Alpine Base" \
      org.label-schema.build-date="2017-02-02T00:12:00+00:00" \
      org.label-schema.name="Alpine 3.5 base image for Swerpbox" \
      org.label-schema.vcs-type="git" \
      org.label-schema.vcs-url="https://github.com/strues/swerpbox" \
      maintainer="Steven Truesdell <steven@strues.io>"

# environment variables
ENV HOME="/root" \
    TERM="xterm"

RUN \
 apk update && \
 apk add --no-cache --virtual=build-deps curl tar && \
 apk add --no-cache bash ca-certificates coreutils shadow tzdata && \

 curl -o /tmp/s6-overlay.tar.gz -L \
	"https://github.com/just-containers/s6-overlay/releases/download/${OVERLAY_VERSION}/s6-overlay-amd64.tar.gz" && \
 tar xfz /tmp/s6-overlay.tar.gz -C / && \

 groupmod -g 1000 users && \
 useradd -u 911 -U -d /config -s /bin/false swerp && \
 usermod -G users swerp && \

 mkdir -p \
	/app \
	/config \
	/data \
	/media \
  /logs \
	/defaults && \

 apk del --purge build-deps && \
 rm -rf /tmp/* /var/cache/apk/*

COPY rootfs/ /

ENTRYPOINT ["/init"]
