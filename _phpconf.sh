#!/bin/sh
export PHP_FPM_USER="www"
export PHP_FPM_GROUP="www"
export PHP_FPM_LISTEN_MODE="0660"
export PHP_MEMORY_LIMIT="512M"
export PHP_MAX_UPLOAD="50M"
export PHP_MAX_FILE_UPLOAD="200"
export PHP_MAX_POST="100M"
export PHP_DISPLAY_ERRORS="On"
export PHP_DISPLAY_STARTUP_ERRORS="On"
export PHP_ERROR_REPORTING="E_COMPILE_ERROR\|E_RECOVERABLE_ERROR\|E_ERROR\|E_CORE_ERROR"
export PHP_CGI_FIX_PATHINFO=0

sed -i "s|;listen.owner\s*=\s*nobody|listen.owner = ${PHP_FPM_USER}|g" /etc/php5/php-fpm.conf 
sed -i "s|;listen.group\s*=\s*nobody|listen.group = ${PHP_FPM_GROUP}|g" /etc/php5/php-fpm.conf 
sed -i "s|;listen.mode\s*=\s*0660|listen.mode = ${PHP_FPM_LISTEN_MODE}|g" /etc/php5/php-fpm.conf 
sed -i "s|user\s*=\s*nobody|user = ${PHP_FPM_USER}|g" /etc/php5/php-fpm.conf 
sed -i "s|group\s*=\s*nobody|group = ${PHP_FPM_GROUP}|g" /etc/php5/php-fpm.conf 
sed -i "s|;log_level\s*=\s*notice|log_level = notice|g" /etc/php5/php-fpm.conf
sed -i "s|include = |;include = |i" /etc/php5/php-fpm.conf
sed -i "s|listen = 127.0.0.1:9000|listen = /var/run/php5-fpm.sock|i" /etc/php5/php-fpm.conf

sed -i "s|display_errors\s*=\s*Off|display_errors = ${PHP_DISPLAY_ERRORS}|i" /etc/php5/php.ini 
sed -i "s|display_startup_errors\s*=\s*Off|display_startup_errors = ${PHP_DISPLAY_STARTUP_ERRORS}|i" /etc/php5/php.ini 
sed -i "s|error_reporting\s*=\s*E_ALL & ~E_DEPRECATED & ~E_STRICT|error_reporting = ${PHP_ERROR_REPORTING}|i" /etc/php5/php.ini 
sed -i "s|;*memory_limit =.*|memory_limit = ${PHP_MEMORY_LIMIT}|i" /etc/php5/php.ini 
sed -i "s|;*upload_max_filesize =.*|upload_max_filesize = ${PHP_MAX_UPLOAD}|i" /etc/php5/php.ini 
sed -i "s|;*max_file_uploads =.*|max_file_uploads = ${PHP_MAX_FILE_UPLOAD}|i" /etc/php5/php.ini 
sed -i "s|;*post_max_size =.*|post_max_size = ${PHP_MAX_POST}|i" /etc/php5/php.ini 
sed -i "s|;*cgi.fix_pathinfo=.*|cgi.fix_pathinfo= ${PHP_CGI_FIX_PATHINFO}|i" /etc/php5/php.ini

export TIMEZONE="Europe/Helsinki" 
cp /usr/share/zoneinfo/${TIMEZONE} /etc/localtime 
echo "${TIMEZONE}" > /etc/timezone 
sed -i "s|;*date.timezone =.*|date.timezone = ${TIMEZONE}|i" /etc/php5/php.ini

echo 'fastcgi_param GEOIP_COUNTRY_CODE $geoip_country_code;' >> /etc/nginx/fastcgi.conf
echo 'fastcgi_param GEOIP_COUNTRY_CODE3 $geoip_country_code3;' >> /etc/nginx/fastcgi.conf
echo 'fastcgi_param GEOIP_COUNTRY_NAME $geoip_country_name;' >> /etc/nginx/fastcgi.conf
