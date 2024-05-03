# google-spreadsheet-buffer

```shell
docker run -d -e BUFFER_PASSWORD=Secret1234! -p 6612:6612 javanile/buffer
```

```shell
## Export 
export BUFFER_TOKEN=$(echo -n '{"password":"'${BUFFER_PASSWORD}'"}' | base64)

curl -H "Authorization: Bearer ${BUFFER_TOKEN}" localhost:6612 -d '
  CREATE TABLE my_table (
    my_field_1 VARCHAR(100),
    my_field_2 VARCHAR(100)
  );  
  INSERT INTO my_table (my_field_1, my_field_2) VALUES ("Hello", "World");
'
```

```
=BUFFER_QUERY("Secret1234!@")
```

```javascript
function GSB_QUERY(url, query, options) {
  const accessToken = {};
  const regex = /^(?:([A-Za-z]+):\/\/)?(?:([A-Za-z0-9_]+):)?([A-Za-z0-9\-._~%!$&'()*+,;=]+)@([A-Za-z0-9.-]+)(?::([0-9]+))?(?:\/([A-Za-z0-9_]+))?$/;
  const match = url.match(regex);
  
  if (!match) {
    throw "Malformed url";
  }
  
  match[1] = String(match[1] || 'https').toLowerCase();
  match[5] = match[5] ? ':' + match[5] : (match[1] != 'https' ? ':6612' : '');

  accessToken.database = match[6] || (match[2] || "buffer");
  accessToken.username = match[2] || "buffer";
  accessToken.password = match[3];
  
  url = match[1] + '://' + match[4] + match[5] + '?options=' + options;    
  
  var response = UrlFetchApp.fetch(url, {
    headers: {
      "Authorization": "Bearer " + Utilities.base64Encode(JSON.stringify(accessToken)),
      "ngrok-skip-browser-warning": "69420"
    },
    payload: query
  });

  return JSON.parse(response.getContentText())
}
```
