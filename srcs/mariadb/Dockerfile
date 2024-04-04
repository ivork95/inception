# FROM debian:oldstable
# EXPOSE 3306

# RUN apt-get update && apt-get upgrade -y \
#     && apt-get install -y \
#     mariadb-server

# COPY tools/setup_mariadb.sh /usr/bin/
# RUN chmod +x /usr/bin/setup_mariadb.sh

# RUN mkdir -p /var/run/mysqld; \
#     chown -R mysql:root /var/run/mysqld

# # Not sure what this does, but removing it breaks mariadb
# RUN mkdir -p /var/run/mysqld;\
# 	chmod 777 /var/run/mysqld /var/lib/mysql;

# RUN sed -i "s/bind-address.*/bind-address = mariadb/" /etc/mysql/mariadb.conf.d/50-server.cnf

# ENTRYPOINT [ "setup_mariadb.sh" ]

# CMD [ "mysqld" ]

FROM debian:oldstable

RUN apt update -y && apt upgrade -y

# gettext-base provides the envsubst command
RUN apt install -y\
	mariadb-server\
	gettext-base

# Not sure what this does, but removing it breaks mariadb
RUN mkdir -p /var/run/mysqld;\
	chmod 777 /var/run/mysqld /var/lib/mysql;

# Allows wordpress to connect using the name mariadb
RUN sed 's/bind-address .*/bind-address = mariadb/' -i /etc/mysql/mariadb.conf.d/50-server.cnf

# Connect mariadb with the database_volume /var/lib/mysql
# we set up in docker-compose.yml
RUN mysql_install_db --user=mysql --datadir=/var/lib/mysql

COPY tools/start.sh /home/start.sh
COPY tools/start.sql /home/start.sql
RUN chmod 777 /home/start.sh /home/start.sql;
CMD [ "/home/start.sh" ]
# CMD ["tail", "-f"]
