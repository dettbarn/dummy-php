FROM php:8.3-fpm-alpine AS dummy-php
RUN apk add composer

# for phpmetrics
RUN apk add libxml2 libxml2-dev php-dom php-tokenizer

# for codesniffer
RUN apk add php-simplexml php-xmlwriter

# for psalm
RUN apk add php-ctype

# for phpunit
RUN apk add php-xml

# for infection
RUN apk add --update linux-headers
RUN apk add --no-cache $PHPIZE_DEPS \
    && pecl install xdebug \
    && docker-php-ext-enable xdebug

# for dependencygraph
RUN apk add graphviz

WORKDIR /app
COPY . .
