FROM debian:buster

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install mariadb-server -y

COPY tools/ /tmp/mariadb/

RUN sed 's/bind-address            = 127.0.0.1/bind-address            = 0.0.0.0/'\
	-i /etc/mysql/mariadb.conf.d/50-server.cnf
RUN service mysql start && mariadb -u root < /tmp/mariadb/setup.sql

EXPOSE 3306

CMD ["mysqld"]
