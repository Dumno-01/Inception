FROM debian:oldstable
RUN apt update -y
RUN apt upgrade -y
RUN apt-get -y install wget
RUN apt-get install -y php7.3\
						php-fpm\
						php-mysql\
						mariadb-client
RUN wget https://fr.wordpress.org/wordpress-6.0-fr_FR.tar.gz -P /var/www
RUN cd /var/www && tar -xzf wordpress-6.0-fr_FR.tar.gz && rm wordpress-6.0-fr_FR.tar.gz
RUN	chown -R root:root /var/www/wordpress
RUN mkdir -p /run/php
RUN	chown -R www-data:www-data /run/php
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp
COPY conf/config-wp.sh /etc/wordpress/config-wp.sh
COPY conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf
RUN chmod +x /etc/wordpress/config-wp.sh
ENTRYPOINT [ "/etc/wordpress/config-wp.sh" ]
CMD [ "php-fpm7.4", "-F" ]
