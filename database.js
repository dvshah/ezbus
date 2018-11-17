var mysql = require('mysql');
var util = require('util');

var connection = mysql.createPool({
	host: process.env.DB_HOST || 'localhost',
	database: process.env.DB_NAME || 'testdb',
	user: process.env.DB_USER || 'root',
	password: process.env.DB_PASS || 'devansh123'
});


connection.query = util.promisify(connection.query);

module.exports.connection = connection;