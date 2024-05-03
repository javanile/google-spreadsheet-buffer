# Google Spreadsheet Buffer

Buffer is a lightweight Docker project designed to serve as a wrapper for MariaDB databases. 
It exposes REST APIs allowing users to send SQL queries to a MariaDB database. 
This project also includes a custom function `BUFFER_QUERY` which enables the execution of SQL queries directly from Google Spreadsheet.

## Table of Contents

- [Installation](#installation)
- [Usage](#usage)
- [Endpoints](#endpoints)
- [Custom Function](#custom-function)
- [Contributing](#contributing)
- [License](#license)

## Installation

To run Buffer locally, make sure you have Docker installed on your system. Then follow these steps:

1. Clone this repository:

    ```
    git clone https://github.com/javanile/google-spreadsheet-buffer.git
    ```

2. Navigate to the project directory:

    ```
    cd google-spreadsheet-buffer
    ```

3. Run the Docker container:

    ```
    make start
    ```

Buffer is now running locally on port 6612.

Please note: For testing in a public environment, remember to modify the `BUFFER_PASSWORD` variable in the `docker-compose.yml` file to ensure security.

## Usage

To use Buffer, you can send HTTP requests to the exposed REST endpoints. Additionally, you can leverage the custom function BUFFER_QUERY directly from Google Spreadsheet to execute SQL queries on the database.

Please note that when using Buffer locally, you'll need to install Ngrok to expose the local container to your Google Sheets:

Install Ngrok on your system following the instructions provided on the Ngrok website.
Run Ngrok and expose the local port where Buffer is running by executing the following command:
    
```
ngrok http 6612
```

Copy the Ngrok URL provided (e.g., https://randomstring.ngrok.io).

Configure Google Sheets to use the Ngrok URL as the endpoint for BUFFER_QUERY function.

With Ngrok set up, you can now interact with your local Buffer instance directly from your Google Spreadsheet!"

## Examples

Run as standalone container

```shell
docker run -d -e BUFFER_PASSWORD=Secret1234! -p 6612:6612 javanile/buffer
```

Create table and insert data

```shell
 export BUFFER_TOKEN=$(echo -n '{"password":"'${BUFFER_PASSWORD}'"}' | base64)

curl -H "Authorization: Bearer ${BUFFER_TOKEN}" localhost:6612 -d '
  CREATE TABLE my_table (
    my_field_1 VARCHAR(100),
    my_field_2 VARCHAR(100)
  );  
  INSERT INTO my_table (my_field_1, my_field_2) VALUES ("Hello", "World");
'
```

Execute query inside Google Spreadsheet

```shell    
=BUFFER_QUERY("secret@b48d-1X6-1X7-1X5-Y4.ngrok-free.app"; "SELECT * FROM my_table")
```

## Custom Function

Buffer includes a custom function `BUFFER_QUERY` which allows users to execute SQL queries directly from Google Spreadsheet. 
Simply include the function in your spreadsheet and provide the SQL query as an argument.

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

## Contributing

Contributions are welcome! Feel free to submit pull requests or open issues for any enhancements or bug fixes.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
