FROM php:7.0-apache
MAINTAINER mike@odania-it.com

RUN apt-get update \
	&& apt-get install -y --no-install-recommends unzip libpng12-dev \
	&& rm -rf /var/lib/apt/lists/*

RUN curl -o spdownload.zip http://www.seopanel.in/spdownload/ && unzip spdownload.zip && rm spdownload.zip && mv seopanel/* . && rmdir seopanel
RUN docker-php-ext-install -j$(nproc) gd
RUN docker-php-ext-install -j$(nproc) mysqli

ADD prepare_config.sh /prepare_config.sh
RUN /prepare_config.sh
RUN chmod 666 config/sp-config.php
RUN chmod -R 777 tmp/
