var database = require('./database');
module.exports = function(name){
	database.connection.query("select stn_id from STATION where stn_name = ?",[name],
		function(err, rows, fields){
			if(err) throw err;
			console.log(rows);
			return rows;
	});
}