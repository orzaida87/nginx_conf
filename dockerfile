FROM alpine:latest
RUN mkdir /conf
ADD _* /conf/
RUN apk update \
    && apk --no-cache add openrc \
    curl \
    git \
    wget \
    nginx \
    nginx-mod-http-geoip \
    php5 \ 
    php5-fpm \
    php5-zlib  \
    php5-openssl \
    php5-json \
    php5-fpm \
    php5-phar \
    supervisor \
    tzdata \
    && adduser -D -g 'www' www \
    && mkdir /www \
    && chown -R www:www /var/lib/nginx \
    && chown -R www:www /www \
    && mkdir /run/nginx \
    && mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.orig \
    && cp /conf/_nginx.conf /etc/nginx/nginx.conf \
    && cp /conf/_index.html /www/index.html \
    && cp /conf/_supervisord.conf /etc/supervisord.conf \
    && chmod +x /conf/_phpconf.sh \
    && chmod +x /conf/_start.sh \
    && ./conf/_phpconf.sh \
    && cp /conf/_phpinfo.php /www/phpinfo.php \
    && cp /conf/_geo.php /www/geo.php \
    && cp /conf/_check.php /www/check.php \
    && curl -sS https://getcomposer.org/installer | php5 -- --install-dir=/usr/bin --filename=composer \
    && curl -sS http://geolite.maxmind.com/download/geoip/database/GeoLiteCountry/GeoIP.dat.gz | gzip -d - > /usr/share/GeoIP/GeoIP.dat \
    && ln /usr/bin/php5 /usr/bin/php \
    && ln /usr/bin/php-fpm5 /usr/bin/php-fpm
EXPOSE 80
CMD ["/bin/sh", "/conf/_start.sh"]
