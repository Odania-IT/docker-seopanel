#!/usr/bin/env bash

sed -e "s/define('SP_WEBPATH', '[a-z0-9/:]*')/define('SP_WEBPATH', getenv('SP_WEBPATH'))/g" \
	-e "s/define('DB_NAME', '[a-z0-9]*')/define('DB_NAME', getenv('DB_NAME'))/g" \
	-e "s/define('DB_USER', '[a-z0-9]*')/define('DB_USER', getenv('DB_USER'))/g" \
	-e "s/define('DB_PASSWORD', '[a-z0-9]*')/define('DB_PASSWORD', getenv('DB_PASSWORD'))/g" \
	-e "s/define('SP_INSTALLED', '\([a-z0-9.]*\)')/if ( getenv('SP_INSTALLED') == 'true' ) { define('SP_INSTALLED', '\1'); }/g" \
	./config/sp-config-sample.php > ./config/sp-config.php
