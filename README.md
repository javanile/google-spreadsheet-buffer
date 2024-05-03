# google-spreadsheet-buffer
google-spreadsheet-sql

```shell
docker run -d -e BUFFER_PASSWORD=Secret1234! -p 6612:6612 javanile/buffer
```

```shell
## Export 
export BUFFER_TOKEN=$(echo -n '{"password":"'${BUFFER_PASSWORD}'"}' | base64)

curl -H "Authorization: Bearer ${BUFFER_TOKEN}" localhost:6612 -d '
  CREATE TABLE my_table (
    my_field VARCHAR(100)
  );
  
'
```

```
=BUFFER_QUERY("Secret1234!@")
```

