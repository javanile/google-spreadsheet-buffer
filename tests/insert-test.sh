#!/bin/bash

docker compose up -d --build --force-recreate

sleep 5

echo
echo "-----------------------------------------"
curl localhost:6612 -d '
  SHOW TABLES;
  SHOW TABLES;
  '

echo
