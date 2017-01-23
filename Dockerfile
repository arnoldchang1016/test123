FROM busybox:latest
MAINTAINER Arnold Chang <arnoldchang1016@gmail.com>
RUN mkdir -p /var/lib/mysql && mkdir -p /var/www/html
VOLUME ["var/lib/mysql", "/var/www/html"]


