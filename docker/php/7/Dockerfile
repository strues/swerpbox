FROM swerpbox/php-base

MAINTAINER Steven Truesdell <steven@strues.io>

RUN apk update \
	&& apk add --no-cache --virtual .build-php \
		$PHPIZE_DEPS \
		libmcrypt-dev \
		curl-dev \
		build-base \
		linux-headers \
		libedit-dev \
		libxml2-dev \
		libressl \
		sqlite-dev \
		libxpm-dev \
		libaio-dev \
		libjpeg-turbo-dev \
		libpng-dev \

		icu-dev \
		freetype-dev gettext-dev libxslt-dev zlib-dev imap-dev gettext-dev \
		sed \
	&& docker-php-ext-install \
		json sockets mcrypt curl xsl gettext mbstring xml xmlrpc opcache \
	&& docker-php-ext-enable json sockets mcrypt curl xsl gettext mbstring xml xmlrpc opcache \
	&& apk del .build-php


  EXPOSE 9000
  ENTRYPOINT ["/init"]
