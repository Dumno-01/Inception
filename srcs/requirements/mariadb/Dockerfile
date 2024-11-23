FROM debian:oldstable


# Install MariaDB
RUN apt update -y && apt upgrade -y
RUN apt install mariadb-server -y

# Copy Configuration and Script
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY tools/scriptsql.sh /etc/mysql/scriptsql.sh
RUN chmod +x /etc/mysql/scriptsql.sh

# Entry Point
ENTRYPOINT ["/etc/mysql/scriptsql.sh"]
CMD [ "mysqld_safe" ]
