FROM debian:oldstable


RUN apt update -y && apt upgrade -y
RUN apt-get install -y --no-install-recommends mariadb-server
RUN mkdir /run/mysqld/ && chown -R mysql:mysql /run/mysqld/

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY tools/scriptsql.sh /etc/mysql/scriptsql.sh
RUN chmod +x /etc/mysql/scriptsql.sh

ENTRYPOINT ["/etc/mysql/scriptsql.sh"]
CMD [ "mysqld_safe" ]
