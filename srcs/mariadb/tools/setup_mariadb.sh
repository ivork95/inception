#!/bin/bash

rm -f /health_check_file.test

echo "setup_mariadb.sh -> Installing MariaDB database"
mysql_install_db    --user=mysql \
                    --datadir=/var/lib/mysql
echo $MYSQL_DATABASE
{
    echo "FLUSH PRIVILEGES;"

    # Create database
    echo "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;"

    # Create database user
    echo "CREATE USER IF NOT EXISTS $MYSQL_USER@'%' IDENTIFIED BY '$MYSQL_PASSWORD';"
    echo "GRANT ALL ON *.* TO $MYSQL_USER@'%' IDENTIFIED BY '$MYSQL_PASSWORDS';"

    # Making sure permissions are applied
    echo "FLUSH PRIVILEGES;"

} | mariadbd --bootstrap

echo "setup done"
touch /health_check_file.test

exec "$@"