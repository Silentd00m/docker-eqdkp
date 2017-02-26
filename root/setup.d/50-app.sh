if [ ! -f "/webroot/index.php" ]; then
        git clone "https://github.com/EQdkpPlus/core" /webroot
        cd /webroot
        git checkout tags/2.2.14

	touch /webroot/config.php
	chmod -R 0777 /webroot/config.php /webroot/data
fi

if [ "$GAME_FFXIV" == "y" ]; then
        git clone https://github.com/EQdkpPlus/game-ffxiv /webroot/games/ffxiv
        cd /webroot/games /ffxiv
        git checkout tags/3.1.1
fi

if [ "$GAME_WOW" == "y" ]; then
        git clone https://github.com/EQdkpPlus/game-wow /webroot/games/wow
        cd /webroot/games/wow
        git checkout tags/7.0.6
fi

if [ "$INCLUDE_DATABASE" == "y" ]; then
	printf "Installing mariadb locally..."

	apk --update add mariadb
	mysql_install_db --user=mysql

	if [ ! -d "/etc/services.d/mariadb" ]; then
		mkdir /etc/services.d/mariadb
	fi

	if [ ! -f "/etc/services.d/mariadb/run" ]; then
		cp /default/services.d/mariadb/run /etc/services.d/mariadb/run
	fi

	printf " [done]\n"
fi
