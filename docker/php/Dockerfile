FROM php:7.4-fpm-alpine
ARG TIMEZONE

COPY docker/php/php.ini /usr/local/etc/php/conf.d/docker-php-config.ini

# Install and configure PHP extension
COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/local/bin/
RUN install-php-extensions \
    exif gd intl opcache pdo_mysql xdebug xsl zip @composer

# Needed by composer
RUN apk add -U git gnupg unzip

# Set timezone
RUN ln -snf /usr/share/zoneinfo/${TIMEZONE} /etc/localtime && echo ${TIMEZONE} > /etc/timezone \
    && printf '[PHP]\ndate.timezone = "%s"\n', ${TIMEZONE} > /usr/local/etc/php/conf.d/tzone.ini

WORKDIR /var/www/app
