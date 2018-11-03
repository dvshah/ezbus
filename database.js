var mysql = require('mysql');

var connection = mysql.createConnection({
	host: 'localhost',
	database: 'testdb',
	user: 'root',
	password: 'devansh123'
});

connection.connect(function(err){
	if(!err){
		console.log('Connected');
	}
	else
	{
		console.log('FUCK!!!!!');
	}
})

module.exports.connection = connection;