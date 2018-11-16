var mysql = require('mysql');
var util = require('util');

var connection = mysql.createPool({
	host: 'localhost',
	database: 'testdb',
	user: 'root',
	password: 'devansh123'
});


connection.query = util.promisify(connection.query);

module.exports.connection = connection;