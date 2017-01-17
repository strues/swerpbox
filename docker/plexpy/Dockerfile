FROM swerpbox/alpine-base

MAINTAINER Steven Truesdell <steven@strues.io>

ARG BUILD_DATE
ARG VERSION
LABEL build_version="SwerpBox PlexPy v:- ${VERSION} Built:- ${BUILD_DATE}"

COPY rootfs/ /

# ports and volumes
VOLUME ["/config", "/logs"]
EXPOSE 8181
