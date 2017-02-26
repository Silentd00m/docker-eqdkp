printf "Creating default configuration files for nginx..."

if [ ! -d "/config/nginx" ]; then
	mkdir /config/nginx
fi

if [ ! -f "/config/nginx/nginx.conf" ]; then
	cp -R /default/config/nginx/nginx.conf /config/nginx/nginx.conf
fi

if [ ! -f "/config/nginx/fastcgi_params" ]; then
        cp -R /default/config/nginx/fastcgi_params /config/nginx/fastcgi_params
fi

if [ ! -d "/config/nginx/site-confs" ]; then
	mkdir /config/nginx/site-confs
fi

if [ ! -f "/config/nginx/site-confs/default" ]; then
	cp /default/config/nginx/site-confs/default /config/nginx/site-confs/default
fi

printf " [done]\n"

printf "Fixing file permissions for nginx..."
chown -R www:www-data /var/lib/nginx
printf " [done]"
