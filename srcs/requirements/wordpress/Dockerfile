FROM debian:bookworm

RUN apt-get update && \
	apt-get -y install wget \
	php8.2-fpm php-mysql \
	php-curl php-gd php-intl php-mbstring php-soap php-xml php-xmlrpc php-zip php-imagick php-dom php-exif php-igbinary php-mbstring

RUN	mkdir -p /var/www/html && \
	wget https://wordpress.org/wordpress-6.7.2.tar.gz -O /tmp/wordpress.tar.gz && \
    tar -xzf /tmp/wordpress.tar.gz -C /var/www/html --strip-components=1 && \
    rm /tmp/wordpress.tar.gz

#RUN find /var/www/html -type d -exec chmod 755 {} \; && \
#	find /var/www/html -type f -exec chmod 644 {} \; && \
#	chown -R www-data:www-data /var/www/html 

WORKDIR /var/www/html

EXPOSE 9000

COPY entrypoint_wp.sh /entrypoint_wp.sh

RUN chmod +x /entrypoint_wp.sh

ENTRYPOINT [ "/entrypoint_wp.sh" ]

CMD ["php-fpm8.2", "-F"]