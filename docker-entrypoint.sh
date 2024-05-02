#!/bin/bash

source /usr/local/bin/mariadb-entrypoint.sh


php -S 0.0.0.0:6612 /var/www/html/server.php &


_main "$@"


