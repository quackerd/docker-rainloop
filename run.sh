#!/bin/sh
set -xe
chown -R www-data:www-data /var/www/rainloop
service php7.3-fpm start
exec nginx -g "daemon off;"
