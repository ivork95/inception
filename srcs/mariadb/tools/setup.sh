chown -R mysql:mysql /var/lib/mysql
mysql_install_db --basedir=/usr --datadir=/var/lib/mysql --user=mysql

echo running setup
mysqld --bootstrap < /tmp/mariadb/setup.sql
echo done running setup

exec /usr/bin/mysqld_safe --datadir='/var/lib/mysql'