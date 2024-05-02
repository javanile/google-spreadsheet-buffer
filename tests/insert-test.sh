#!/bin/bash

docker compose up -d --build --force-recreate

sleep 5

ACCESS_TOKEN=$(echo -n '{"database":"mysql"}' | base64)

echo
echo "-----------------------------------------"
curl localhost:6612 \
  -H "Authorization: Bearer ${ACCESS_TOKEN}" \
  -d "SHOW TABLES;"

echo
