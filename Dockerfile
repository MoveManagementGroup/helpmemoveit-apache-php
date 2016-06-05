# mmginc/helpmemoveit-apache-php

FROM php:5.6-apache

MAINTAINER "Austin Maddox" <austin@maddoxbox.com>

RUN docker-php-ext-install mysql

# Set the "ServerName" directive globally to suppress this message... "Could not reliably determine the server's fully qualified domain name, using #.#.#.#."
COPY ./etc/apache2/conf-available/fqdn.conf /etc/apache2/conf-available/fqdn.conf
RUN a2enconf fqdn \
    && a2enmod rewrite

# Define the virtual host.
COPY ./etc/apache2/sites-available/virtual-host.conf /etc/apache2/sites-available/virtual-host.conf
RUN a2ensite virtual-host

# If needed, add a custom php.ini configuration.
COPY ./usr/local/etc/php/php.ini /usr/local/etc/php/php.ini
