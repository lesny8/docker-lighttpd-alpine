FROM lighttpd-base:latest

# Copy lighttpd config files. At this point it is all default except
# including a custom ssl.conf in lighttpd.conf.
COPY config/lighttpd/* /etc/lighttpd/

# Copy an example index.html to the default webroot to allow
# for demo/testing without needing mounts during `docker run`
#COPY htdocs/index.html /var/www/localhost/htdocs/

# Check every minute if lighttpd responds within 1 second and update
# container health status accordingly.
#HEALTHCHECK --interval=1m --timeout=1s \
#  CMD curl -f http://localhost/ || exit 1

# Expose http(s) ports
#EXPOSE 80 443

# Make configuration path and webroot a volume
#VOLUME /etc/lighttpd/
#VOLUME /var/www/

ENTRYPOINT ["/usr/sbin/lighttpd", "-D", "-f", "/etc/lighttpd/lighttpd.conf"]
