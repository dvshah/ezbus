var mysql = require('mysql');
var util = require('util');

var connection = mysql.createPool({
	host: 'localhost',
	database: 'testdb',
	user: 'root',
	password: 'devansh123'
});

/*connection.connect(function(err){
	if(!err){
		console.log('Connected');
	}
	else
	{
		console.log('FUCK!!!!!');
	}
});
*/
connection.query = util.promisify(connection.query);

module.exports.connection = connection;