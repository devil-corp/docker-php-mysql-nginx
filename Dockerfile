FROM php:8.1-fpm-alpine

# Add Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Add pdo
RUN docker-php-ext-install pdo pdo_mysql

# Add xdebug
RUN apk add --no-cache --virtual .build-deps $PHPIZE_DEPS
RUN apk add --update linux-headers
RUN pecl install xdebug-3.1.5
RUN docker-php-ext-enable xdebug
RUN apk del -f .build-deps

COPY docker/config/xdebug.ini /usr/local/etc/php/conf.d/

WORKDIR /var/www/html