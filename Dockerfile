FROM debian:buster

ENV RAINLOOP_DIR=/var/www/rainloop

WORKDIR /opt

COPY ./run.sh /opt/run.sh

RUN set -xe && \
    apt update -y && \
    apt upgrade -y && \
    apt install -y unzip curl wget php php-curl php-json php-dom php-fpm php-pgsql php-sqlite3 php-mysql nginx && \
    mkdir -p ${RAINLOOP_DIR} && \
    wget https://www.rainloop.net/repository/webmail/rainloop-community-latest.zip && \
    unzip rainloop-community-latest.zip -d ${RAINLOOP_DIR} && \
    rm rainloop-community-latest.zip && \
    mkdir -p /logs && \
    sed -i 's/error_log =.*/error_log = \/logs\/php_fpm.log/g' /etc/php/7.3/fpm/php-fpm.conf && \
    sed -i 's/upload_max_filesize =.*/upload_max_filesize = 100M/g' /etc/php/7.3/fpm/php.ini && \
    sed -i 's/post_max_size =.*/post_max_size = 100M/g' /etc/php/7.3/fpm/php.ini && \
    chown -R www-data:www-data ${RAINLOOP_DIR} && \
    chmod +x /opt/run.sh && \
    apt purge -y --autoremove unzip curl wget && \
    apt clean
    
COPY ./default /etc/nginx/sites-enabled/default

VOLUME ["${RAINLOOP_DIR}/data"]
EXPOSE 80
CMD ["/opt/run.sh"]

