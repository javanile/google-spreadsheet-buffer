#!/bin/bash

docker compose down -v
docker compose up -d --build --force-recreate

while ! curl -sf localhost:6612/_health; do sleep 1; done

export BUFFER_TOKEN=$(echo -n '{"password":"secret"}' | base64)

echo
echo "-----------------------------------------"
curl localhost:6612 \
  -H "Authorization: Bearer ${BUFFER_TOKEN}" \
  -d "CREATE TABLE my_table_1 (
        id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
        title VARCHAR(100) NOT NULL
      );
      CREATE TABLE my_table_2 (
        id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
        title VARCHAR(100) NOT NULL
      );
      SHOW TABLES;
      "

curl localhost:6612 \
  -H "Authorization: Bearer ${BUFFER_TOKEN}" \
  -d "SHOW TABLES;"

echo
