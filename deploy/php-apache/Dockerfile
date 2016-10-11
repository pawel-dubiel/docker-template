FROM php:5.5.37-apache

#COPY config/php.ini /usr/local/etc/php/

COPY config/http_host.conf /etc/apache2/sites-enabled/

#include if you need ssl host
#COPY config/ssl_host.conf /etc/apache2/sites-enabled/


RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev \
        mysql-client \
        libxml2-dev \
        net-tools \
 	vim \
        && docker-php-ext-install pdo pdo_mysql mcrypt soap \
        && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
        && docker-php-ext-install -j$(nproc) gd

RUN a2enmod rewrite ; a2enmod headers ; a2enmod deflate; a2enmod ssl
