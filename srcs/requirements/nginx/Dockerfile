#FROM debian:oldstable
#WORKDIR .
#RUN apt-get update && apt-get install -y nginx
#COPY . .
#ENV PORT=443
#EXPOSE 443
#CMD ["/print_message.sh"]

# Use Debian base
FROM debian:bookworm

# Install NGINX
RUN apt-get update && \
    apt-get install -y nginx openssl && \
    apt-get clean 

# Copy custom config
COPY default.conf /etc/nginx/sites-available/default
RUN ln -sf /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default
# copy certificates for tls
COPY tools/tls/ /etc/nginx/ssl/
# Copy your HTML file into NGINX's root folder
#COPY . /usr/share/nginx/html/

# Expose port 443
EXPOSE 443

# Start NGINX in the foreground
CMD ["nginx", "-g", "daemon off;"]
