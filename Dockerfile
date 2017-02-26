FROM alpine:latest
MAINTAINER André Fischer

RUN echo '@community http://nl.alpinelinux.org/alpine/edge/community' >> /etc/apk/repositories

ENV S6_OVERLAY_RELEASE v1.19.1.1
ENV TMP_BUILD_DIR /tmp/build

VOLUME ["/config" "/webroot"]

COPY root /
RUN ln -s /config/nginx /etc/nginx && \
	ln -s /config/php7 /etc/php7

ADD https://github.com/just-containers/s6-overlay/releases/download/${S6_OVERLAY_RELEASE}/s6-overlay-nobin.tar.gz ${TMP_BUILD_DIR}/
ADD https://github.com/just-containers/s6-overlay/releases/download/${S6_OVERLAY_RELEASE}/s6-overlay-nobin.tar.gz.sig ${TMP_BUILD_DIR}/

COPY keys/trust.gpg ${TMP_BUILD_DIR}/

RUN apk add --update s6 s6-portable-utils && \
	apk add --virtual verify gnupg

WORKDIR ${TMP_BUILD_DIR}
RUN gpg --no-default-keyring --keyring ./trust.gpg s6-overlay-nobin.tar.gz.sig && \
	apk del verify && \
	tar -C / -xf s6-overlay-nobin.tar.gz

WORKDIR /
RUN rm -rf /var/cache/apk/* && \
	rm -rf  {TMP_BUILD_DIR}

RUN apk add --update \
	busybox \
	nginx \
	php7 \
        php7-bcmath \
        php7-dom \
        php7-ctype \
        php7-curl \
        php7-fpm \
        php7-gd \
        php7-iconv \
        php7-intl \
        php7-json \
        php7-mbstring \
        php7-mcrypt \
        php7-mysqlnd \
        php7-opcache \
        php7-openssl \
        php7-pdo \
        php7-pdo_mysql \
        php7-pdo_pgsql \
        php7-pdo_sqlite \
        php7-phar \
        php7-posix \
        php7-session \
        php7-soap \
        php7-xml \
        php7-zip \
	php7-zlib \
	php7-curl \
	php7-gd \
	php7-json \
	php7-zip \
	php7-session \
	mariadb-client \
	coreutils \
	bash \
	git \
	imagemagick

EXPOSE 80

CMD bash /run.sh
