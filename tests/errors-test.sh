#!/bin/bash

empty_access_token=$(echo -n '{}' | base64)
empty_password_access_token=$(echo -n '{"password":""}' | base64)
wrong_password_access_token=$(echo -n '{"password":"wrong"}' | base64)
correct_access_token=$(echo -n '{"password":"root"}' | base64)

curl localhost:6612
curl -H "Authorization: Bearer ${empty_access_token}" localhost:6612
curl -H "Authorization: Bearer ${empty_password_access_token}" localhost:6612
curl -H "Authorization: Bearer ${wrong_password_access_token}" localhost:6612
curl -H "Authorization: Bearer ${correct_access_token}" localhost:6612 -d "SELECT * FROM wrong_table"
