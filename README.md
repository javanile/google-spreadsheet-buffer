# google-spreadsheet-buffer
google-spreadsheet-sql

```shell
docker run -d -e BUFFER_PASSWORD=Secret1234! -p 6612:6612 javanile/buffer
```

```shell
export BUFFER_TOKEN=$(echo -n '{"password":"'${BUFFER_PASSWORD}'"}' | base64)
curl -H "Authorization: Bearer ${BUFFER_TOKEN}" localhost:6612 -d ''
```


