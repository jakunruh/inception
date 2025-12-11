FROM debian:bookworm

# so the installation runs automatically instead of asking questions
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
	apt-get upgrade -y && \
	apt-get install -y mariadb-server && \
	apt-get clean

# Ensure mysql data directory exists
RUN mkdir -p /run/mysqld && \
	chown -R mysql:mysql /run/mysqld

# overwrite bind addresses so it can connect to all network interfaces (incl docker)
RUN echo "[mysqld]\nbind-address=0.0.0.0" > /etc/mysql/mariadb.conf.d/99-bind-address.cnf

COPY entrypoint_mariadb.sh /entrypoint_mariadb.sh

RUN chmod +x /entrypoint_mariadb.sh

EXPOSE 3306

ENTRYPOINT ["./entrypoint_mariadb.sh"]