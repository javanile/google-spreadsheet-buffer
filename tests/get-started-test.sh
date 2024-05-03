#!/bin/bash

docker compose down -v
docker compose up -d --build --force-recreate

sleep 5

export BUFFER_TOKEN=$(echo -n '{"password":"secret"}' | base64)

echo
echo "-----------------------------------------"
curl localhost:6612 \
  -H "Authorization: Bearer ${BUFFER_TOKEN}" \
  -d "CREATE TABLE my_table (
        id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
        title VARCHAR(100) NOT NULL
      );"

echo
