#!/bin/sh
set -xe
service php7.3-fpm start
exec nginx -g "daemon off;"
