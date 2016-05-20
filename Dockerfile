# mmginc/helpmemoveit-apache-php

FROM php:7.0-apache

MAINTAINER "Austin Maddox" <austin@maddoxbox.com>

RUN apt-get update

RUN docker-php-ext-install mysqli

# Set the "ServerName" directive globally to suppress this message... "Could not reliably determine the server's fully qualified domain name, using #.#.#.#."
COPY ./etc/apache2/conf-available/fqdn.conf /etc/apache2/conf-available/fqdn.conf
RUN a2enconf fqdn

# Define the default virtual host.
COPY ./etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/000-default.conf
RUN a2ensite 000-default \
	&& a2enmod rewrite

# If needed, add a custom php.ini configuration.
COPY ./usr/local/etc/php/php.ini /usr/local/etc/php/php.ini

# Cleanup
RUN apt-get clean \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
