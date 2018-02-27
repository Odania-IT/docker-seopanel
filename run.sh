#!/bin/bash
set -e

if [[ "${SP_INSTALLED}" == "true" ]]; then
	rm -rf /var/www/html/install
	chmod 0444 /var/www/html/config/sp-config.php

    sed -e "s/define('SP_WEBPATH', '[a-z0-9/:]*')/define('SP_WEBPATH', '$SP_WEBPATH')/g" \
        -e "s/define('DB_HOST', '[a-z0-9]*')/define('DB_HOST', '$DB_HOST')/g" \
        -e "s/define('DB_NAME', '[a-z0-9]*')/define('DB_NAME', '$DB_NAME')/g" \
        -e "s/define('DB_USER', '[a-z0-9]*')/define('DB_USER', '$DB_USER')/g" \
        -e "s/define('DB_PASSWORD', '[a-z0-9]*')/define('DB_PASSWORD', '$DB_PASSWORD')/g" \
        /var/www/html/config/sp-config-sample.php > /var/www/html/config/sp-config.php
fi

exec apache2-foreground
