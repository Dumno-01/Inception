FROM debian:oldstable

RUN apt-get update
RUN apt-get upgrade -y

RUN apt-get install -y --no-install-recommends \
        wordpress \
        php-cli \
        php-mysql \
        php-fpm \
        curl

RUN mkdir /run/php/
RUN chown -R www-data:www-data /run/php/

COPY conf/config-wp.sh /usr/local/bin/
COPY conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

RUN chmod +x /usr/local/bin/config-wp.sh

EXPOSE 9000

ENTRYPOINT [ "/usr/local/bin/config-wp.sh" ]
CMD [ "php-fpm7.4", "-F" ]
