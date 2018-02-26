FROM php:7.0-apache
MAINTAINER mike@odania-it.com

RUN apt-get update \
	&& apt-get install -y --no-install-recommends unzip libpng12-dev cron supervisor \
	&& rm -rf /var/lib/apt/lists/*

RUN curl -o spdownload.zip https://www.seopanel.in/spdownload/ && unzip spdownload.zip && rm spdownload.zip && mv seopanel/* . && rmdir seopanel
RUN docker-php-ext-install -j$(nproc) gd
RUN docker-php-ext-install -j$(nproc) mysqli

RUN echo "#!/bin/php\n<?php file_get_contents('http://127.0.0.1'); " > /var/www/html/crontest.php

ADD supervisord.conf /etc/supervisor/conf.d/

ADD run.sh /run.sh
ADD prepare-config.sh /prepare-config.sh
RUN /prepare-config.sh
RUN chown -R www-data:www-data /var/www/html
RUN chmod 666 /var/www/html/config/sp-config.php
RUN chmod -R 777 /var/www/html/tmp/

#supervisord
# RUN mkdir /var/log/supervisor/ && touch /var/log/supervisor/supervisord.log
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN echo "* * * * * root /usr/local/bin/php /var/www/html/crontest.php >> /var/log/cron.log 2>&1" > /etc/cron.d/seopanel
RUN echo "0 0,6 * * * root /usr/local/bin/php /var/www/html/proxycheckercron.php >> /var/log/cron.log 2>&1" >> /etc/cron.d/seopanel
RUN echo "*/15 * * * * root /usr/local/bin/php /var/www/html/cron.php >> /var/log/cron.log 2>&1" >> /etc/cron.d/seopanel

RUN chmod 0644 /etc/cron.d/seopanel

CMD /usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf
