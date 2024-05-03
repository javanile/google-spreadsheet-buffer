# Examples

Generate access token

```shell
echo -n '{"password":"l0ngS3cur3P4ss"}' | base64
```

Create table and insert data

```shell
curl -H "Authorization: Bearer eyJwYXNzd29yZCI6ImwwbmdTM2N1cjNQNHNzIn0=" localhost:6612 -d '
  CREATE TABLE my_table (
    my_field_1 VARCHAR(100),
    my_field_2 VARCHAR(100)
  );  
  INSERT INTO my_table 
              ( my_field_1, my_field_2) 
       VALUES ("Hello",    "World")
            , ("¡Hola",    "Mundo!")
            , ("Ciao",     "Mondo!")
            , ("Bonjour",  "Monde!");
'
