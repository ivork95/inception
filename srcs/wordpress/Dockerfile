FROM debian:oldstable

RUN apt update -y && apt upgrade -y

RUN apt install -y\
	php7.4\
	php7.4-fpm\
	php7.4-mysql\
	mariadb-client


ADD https://wordpress.org/wordpress-6.4.2.tar.gz /var/www/wordpress.tar.gz


RUN tar -xzf /var/www/wordpress.tar.gz -C /var/www/
RUN mv /var/www/wordpress/* /var/www/
RUN rmdir /var/www/wordpress
RUN rm /var/www/wordpress.tar.gz
RUN chown -R root:root /var/www/

ADD https://raw.githubusercontent.com/wp-cli/builds/3e345df698faea02d64baebcb2fa6fc523231494/phar/wp-cli-release.phar /usr/local/bin/wp-cli

RUN chmod +x /usr/local/bin/wp-cli
RUN mkdir -p /run/php
RUN sed 's/listen = .*/listen = wordpress:9000/' -i /etc/php/7.4/fpm/pool.d/www.conf
RUN sed 's/;clear_env = no/clear_env = no/' -i /etc/php/7.4/fpm/pool.d/www.conf

COPY tools/setup.sh /home/setup.sh
RUN chmod 777 /home/setup.sh;

CMD [ "/home/setup.sh" ]
