printf "Creating default configuration files for php..."

if [ ! -d "/config/php7" ]; then
	mkdir /config/php7
fi

if [ ! -f "/config/php7/php7.ini" ]; then
	cp -R /default/config/php7/php.ini /config/php7/php.ini
fi

if [ ! -f "/config/php7/php-fpm.conf" ]; then
	cp /default/config/php7/php-fpm.conf /config/php7/php-fpm.conf
fi

printf " [done]\n"
