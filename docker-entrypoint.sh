#!/bin/bash

source /usr/local/bin/mariadb-entrypoint.sh

#php -S 0.0.0.0:6612 /var/www/html/server.php &
echo "<?php require '/var/www/html/server.php';" > /tmp/server.php
php -S 0.0.0.0:6612 /tmp/server.php &

_main "$@"


