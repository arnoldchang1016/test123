FROM wordpress:latest
#RUN set -ex; \
#	\
RUN	apt-get update && apt-get install -y unzip && rm -rf /var/lib/apt/lists/*
#	docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr; \
#	docker-php-ext-install gd mysqli opcache
# TODO consider removing the *-dev deps and only keeping the necessary lib* packages

# set recommended PHP.ini settings
# see https://secure.php.net/manual/en/opcache.installation.php
#RUN { \
#		echo 'opcache.memory_consumption=128'; \
#		echo 'opcache.interned_strings_buffer=8'; \
#		echo 'opcache.max_accelerated_files=4000'; \
#		echo 'opcache.revalidate_freq=2'; \
#		echo 'opcache.fast_shutdown=1'; \
#		echo 'opcache.enable_cli=1'; \
#	} > /usr/local/etc/php/conf.d/opcache-recommended.ini

RUN touch /usr/local/etc/php/conf.d/upload-limit.ini \
         && echo "upload_max_filesize = 32M" >> /usr/local/etc/php/conf.d/upload-limit.ini \
         && echo "post_max_size = 32M" >> /usr/local/etc/php/conf.d/upload-limit.ini

RUN a2enmod expires headers

VOLUME /var/www/html

#ENV WORDPRESS_VERSION 4.7.1
#ENV WORDPRESS_SHA1 8e56ba56c10a3f245c616b13e46bd996f63793d6

#RUN set -ex; \
#	curl -o wordpress.tar.gz -fSL "https://wordpress.org/wordpress-${WORDPRESS_VERSION}.tar.gz"; \
#	echo "$WORDPRESS_SHA1 *wordpress.tar.gz" | sha1sum -c -; \
# upstream tarballs include ./wordpress/ so this gives us /usr/src/wordpress
#	tar -xzf wordpress.tar.gz -C /usr/src/; \
#	rm wordpress.tar.gz; \
#	chown -R www-data:www-data /usr/src/wordpress

COPY docker-entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["apache2","-DFOREGROUND"]
