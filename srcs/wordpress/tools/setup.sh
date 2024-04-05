#!/bin/sh

until mysqladmin ping -hmariadb --silent; do
echo "Waiting for MariaDB to come online..."
	sleep 1
done

if [ ! -f "/var/www/wp-config.php" ]; then
echo "Creating config"
wp-cli config create\
	--allow-root\
	--path=/var/www\
	--dbhost="$MYSQL_HOST"\
	--dbname="$MYSQL_DATABASE"\
	--dbuser="$MYSQL_USER"\
	--dbpass="$MYSQL_PASSWORD"

echo "Running wp core install"
wp-cli core install\
	--allow-root\
	--path=/var/www\
	--skip-email\
	--title="$WP_ADM_TITLE"\
	--admin_name="$WP_ADM_NAME"\
	--admin_password="$WP_ADM_PASS"\
	--admin_email="$WP_ADM_MAIL"\
	--url="$WP_ADM_URL"

echo "Running wp user create"
wp-cli user create\
	"$WP_USER_NAME"\
	"$WP_USER_MAIL"\
	--allow-root\
	--path=/var/www\
	--role=contributor\
	--user_pass="$WP_USER_PASS"
fi

echo "Running php-fpm"
php-fpm7.4 --nodaemonize