# use Debian base
FROM debian:bookworm

# install NGINX
RUN apt-get update && \
    apt-get install -y nginx openssl && \
    apt-get clean 

# copy custom config
COPY default.conf /etc/nginx/sites-available/default

RUN ln -sf /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default

# expose port 443
EXPOSE 443

# start NGINX in the foreground
CMD ["nginx", "-g", "daemon off;"]
