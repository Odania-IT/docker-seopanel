#!/bin/bash
set -e

if [[ "${SP_INSTALLED}" == "true" ]]; then
	rm -rf /var/www/html/install
	chmod 0444 /var/www/html/config/sp-config.php
fi

exec apache2-foreground
