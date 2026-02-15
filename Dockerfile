FROM php:8.3-fpm-alpine AS dummy-php
RUN apk add composer

# for phpmetrics
RUN apk add libxml2 libxml2-dev php-dom php-tokenizer

# for codesniffer
RUN apk add php-simplexml php-xmlwriter

# for psalm
RUN apk add php-ctype

WORKDIR /app
COPY . .
