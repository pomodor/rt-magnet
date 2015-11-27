var mysql      = require('mysql');

var connection = mysql.createConnection({
  host     : 'localhost',
  user     : 'magnet',
  password : 'magnet',
  database : 'magnet'
});

connection.connect();

module.exports = connection;
