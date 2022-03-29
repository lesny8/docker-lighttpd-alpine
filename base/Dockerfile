FROM arm32v7/alpine:3.10
LABEL maintainer="Marcus Meurs <mail@m4rcu5.nl>" \
      version="1.0.0"

# Install packages
RUN apk update && \
    apk add --no-cache \
    lighttpd \
    openssl \
    curl && \
    rm -rf /var/cache/apk/*

# Create lighttpd ssl directory and generate self signed cert
RUN mkdir /etc/lighttpd/ssl/ && \
        openssl req -x509 -newkey rsa:4096 -keyout /tmp/key.pem -out /tmp/cert.pem -days 365 -subj '/CN=localhost' -nodes -sha256 && \
        cat /tmp/key.pem /tmp/cert.pem > /etc/lighttpd/ssl/localhost.pem && \
        rm /tmp/key.pem /tmp/cert.pem && \
        chmod 400 /etc/lighttpd/ssl/localhost.pem

EXPOSE 80 443

# Make configuration path and webroot a volume
#VOLUME /etc/lighttpd/
VOLUME /var/www/
