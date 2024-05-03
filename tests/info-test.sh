#!/bin/bash

docker compose down -v
docker compose up -d --build --force-recreate

while ! curl -sf localhost:6612/_health; do sleep 1; done

export BUFFER_TOKEN=$(echo -n '{"password":"secret"}' | base64)

echo
echo "========================================="
curl localhost:6612 \
  -H "Authorization: Bearer ${BUFFER_TOKEN}" \
  -d "SELECT DATABASE();"

echo
