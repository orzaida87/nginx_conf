FROM alpine:latest
RUN mkdir /conf
ADD _* /conf/
RUN apk update \
    && apk --no-cache add openrc \
    && apk --no-cache add curl \
    && apk --no-cache add git \
    && apk --no-cache add wget \
    && apk add --no-cache nginx \
    && apk add --no-cache nginx-mod-http-geoip \
    && apk add --no-cache php5 \ 
    && apk add --no-cache php5-fpm \
    && apk add --no-cache php5-zlib  \
    && apk add --no-cache php5-openssl \
    && apk add --no-cache php5-json \
    && apk add --no-cache php5-fpm \
    && apk add --no-cache php5-phar \
    && apk add --no-cache supervisor \
    && apk add tzdata \
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
    && curl -sS https://getcomposer.org/installer | php5 -- --install-dir=/usr/bin --filename=composer \
    && curl -sS http://geolite.maxmind.com/download/geoip/database/GeoLiteCountry/GeoIP.dat.gz | gzip -d - > /usr/share/GeoIP/GeoIP.dat
EXPOSE 80
CMD ["/bin/sh", "/conf/_start.sh"]
