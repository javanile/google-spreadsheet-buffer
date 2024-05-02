FROM mariadb:11.3.2-jammy

RUN apt-get update && \
	apt-get install -y --no-install-recommends php php-mysql \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Copia la configurazione di PHP personalizzata, se necessario
# COPY php.ini /etc/php/8.0/cli/php.ini

RUN mv /usr/local/bin/docker-entrypoint.sh /usr/local/bin/mariadb-entrypoint.sh
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

COPY server.php /var/www/html/server.php

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["mariadbd"]
