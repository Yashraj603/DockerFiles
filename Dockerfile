FROM php:7.4-apache

RUN docker-php-ext-install mysqli

COPY app.php /var/www/html/index.php

