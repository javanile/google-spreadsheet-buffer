#!/bin/bash

if [ -z "${BUFFER_PASSWORD}" ]; then
  echo "BUFFER_PASSWORD is not set"
  exit 1
fi

export BUFFER_DATABASE=${BUFFER_DATABASE:-buffer}
export BUFFER_USER=${BUFFER_USER:-buffer}

export MARIADB_ROOT_PASSWORD=${BUFFER_PASSWORD}
export MARIADB_DATABASE=${BUFFER_DATABASE}
export MARIADB_USER=${BUFFER_USER}
export MARIADB_PASSWORD=${BUFFER_PASSWORD}

source /usr/local/bin/mariadb-entrypoint.sh

#php -S 0.0.0.0:6612 /var/www/html/server.php &
echo "<?php require '/var/www/html/server.php';" > /tmp/server.php
php -S 0.0.0.0:6612 /tmp/server.php &

_main "$@"
