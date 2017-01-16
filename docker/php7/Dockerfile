FROM swerpbox/php7-base

MAINTAINER Steven Truesdell <steven@strues.io>

RUN apk update \
	&& apk add --no-cache --virtual .build-php \
		$PHPIZE_DEPS \
    libxml2-dev \
		sed \
	&& docker-php-ext-install \
		json \
    sockets \
		mbstring \
    xml \
		opcache \
	&& docker-php-ext-enable json sockets mbstring xml opcache \
	&& apk del .build-php


  EXPOSE 9000
  ENTRYPOINT ["/init"]
