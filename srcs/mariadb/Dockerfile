FROM debian:oldstable

RUN apt update -y && apt upgrade -y

RUN apt install -y\
	mariadb-server\
	gettext-base

RUN mkdir -p /var/run/mysqld;\
	chmod 777 /var/run/mysqld /var/lib/mysql;

RUN sed 's/bind-address .*/bind-address = mariadb/' -i /etc/mysql/mariadb.conf.d/50-server.cnf

RUN mysql_install_db --user=mysql --datadir=/var/lib/mysql

COPY tools/start.sh /home/start.sh
COPY tools/start.sql /home/start.sql
RUN chmod 777 /home/start.sh /home/start.sql;
CMD [ "/home/start.sh" ]

