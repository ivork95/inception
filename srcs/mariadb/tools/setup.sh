#!/bin/bash

set -e

if [ ! -d "/var/lib/mysql/$MYSQL_DATABASE" ]; then
	echo "Initializing mariadb database"
	< /home/start.sql envsubst | mariadbd --bootstrap
	echo "Initialized mariadb database"
else
	echo "mariadb database was already initialized"
fi

echo "Running mariadbd"
mariadbd
