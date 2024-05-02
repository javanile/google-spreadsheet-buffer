#!/bin/bash

empty_access_token=$(echo -n '{}' | base64)
wrong_password_access_token

curl localhost:6612
curl -H "Authorization: Bearer ${empty_access_token}" localhost:6612
