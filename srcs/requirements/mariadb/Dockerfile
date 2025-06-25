FROM debian:bookworm

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
	apt-get upgrade -y && \
	apt-get install -y mariadb-server && \
	apt-get clean

# Ensure mysql data directory exists
RUN mkdir -p /run/mysqld && \
	chown -R mysql:mysql /run/mysqld

RUN echo "[mysqld]\nbind-address=0.0.0.0" > /etc/mysql/mariadb.conf.d/99-bind-address.cnf


# Initialize the database
#RUN mariadb-install-db --user=mysql --datadir=/var/lib/mysql

#took from mariadb website, doesnt do
#HEALTHCHECK --start-period=5m \
#  CMD mariadb -e 'SELECT @@datadir;' || exit 1

#USER mysql
COPY entrypoint_mariadb.sh /entrypoint_mariadb.sh

RUN chmod +x /entrypoint_mariadb.sh

EXPOSE 3306

ENTRYPOINT ["./entrypoint_mariadb.sh"]
#CMD ["mysqld", "--user=root", "--log-bin", "--lower_case_table_names=2"]