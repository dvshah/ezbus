var express = require('express');
var http = require('http');
var bodyParser = require('body-parser');
var database = require('./database');
var alert = require('alert-node');
var qs = require('querystring');
var cookieParser = require('cookie-parser');
var session = require('express-session');
var nametoid = require('./nametoid');
//alert('haha');
var app = express();

app.set('view engine', 'ejs');

app.use(express.static('./assets'));

/*app.use(cookieParser());*/

var urlencodedParser = bodyParser.urlencoded({ extended: false })


// initialize express-session to allow us track the logged-in user across sessions.
app.use(session({
    key: 'user_sid',
    secret: 'somerandonstuffs',
    resave: false,
    saveUninitialized: false,
}));


// This middleware will check if user's cookie is still saved in browser and user is not set, then automatically log the user out.
// This usually happens when you stop your express server after login, your cookie still remains saved in the browser.

// middleware function to check for logged-in users
var sessionChecker = (req, res, next) => {
    if (req.session.user) {
        res.redirect('/home');
    } else {
        next();
    }    
};

var bussessionChecker = (req, res, next) => {
	if(!req.session.buses) {
		res.redirect('/home');
	}
	else{
		next();
	}
}

app.get('/', function(req,res){
	res.redirect('/home');
})

app.get('/login',sessionChecker, function(req, res){
	console.log('Connected');
	res.render('login');
});

app.post('/login',urlencodedParser,function(req, res){
    var username = req.body.name;
    var password = req.body.password;
		database.connection.query('SELECT * FROM USERS WHERE username = ?', [username],
			function(err, rows, fields){
				if(err)	throw err;
				else
				{
					if(rows.length > 0)
					{
						if(rows[0].password == password)
						{
							req.session.user = username;
							alert('good job!');
							res.redirect('/home');
						}
						else
						{
							alert('password do not match')
							res.redirect('/login');
						}
					}
					else
					{
						alert('name check failed');
						res.redirect('/login');
					}
				}
			});
});

app.get('/register',sessionChecker, function(req, res){
	//console.log('Connected');
	res.render('register');
});

app.post('/register', urlencodedParser, function(req,res){
	var name = req.body.name;
	var username = req.body.username;
	var password = req.body.password;
	database.connection.query('SELECT * FROM USERS WHERE username = ?', [username],
		function(err, rows, fields){
			if(err) throw err;
			else
			{
				if(rows.length>0)
				{
					alert('Username already exists Please try different one!');
					res.redirect('/register');
				}
				else
				{
					database.connection.query('INSERT INTO USERS VALUES (? , ?, ?, ?)',[username,name,password,1000000],
						function(err){
							if(err) throw err;
							alert('User registered!');
							res.redirect('/login');
						})
				}
			}
		})
});

app.get('/home', function(req,res){
	var someVar = [];

	database.connection.query("select * from STATION", function(err, rows){
	  if(err) {
	    throw err;
	  } else {
	    someVar = rows;
	    console.log();
		var check = req.session.user;
		res.render('home',{name: check, stations: someVar});
	  }
	});
});



app.post('/home', urlencodedParser, function(req,res){
	//console.log(stations);
	//alert(stations);
	//console.log(req.body);
	var from = req.body.from;
	var to = req.body.to;
	if(from==to)
	{
		alert('starting point and destination cant be same! ');
		res.redirect('/home');
	}
	var date = req.body.date;
	var year = date.substring(0,4);
	var month = date.substring(5,7);
	var day = date.substring(8,10);
	async function example(from,to){
		try {
		    var alpha = await database.connection.query('SELECT * FROM STATION WHERE stn_name = ?',[from]);
		    var beta = await database.connection.query('SELECT * FROM STATION WHERE stn_name = ?',[to]);
		    var rows = [alpha,beta]
		} catch(err) {
		    throw new Error(err)
		}
		var alpha = rows[0][0].stn_id;
		var beta = rows[1][0].stn_id;
		if(beta>alpha)
		{
			var bus = await database.connection.query('SELECT START.bus_id FROM START WHERE START.stn_id<=? AND START.bus_id IN (SELECT DESTINATION.bus_id FROM DESTINATION WHERE DESTINATION.stn_id>=?)', [alpha,beta]);
			if(bus.length == 0)
			{
				alert('NO BUSES!');
				res.redirect('/home');
			}
			else
			{
				req.session.buses = bus;
				req.session.day = day;
				req.session.month = month;
				req.session.year = year;
				res.redirect('/buses');
			}
		}
		else
		{
			var bus = await database.connection.query('SELECT START.bus_id FROM START WHERE START.stn_id<=? AND START.bus_id IN (SELECT DESTINATION.bus_id FROM DESTINATION WHERE DESTINATION.stn_id>=?)', [beta, alpha]);
			if(bus.length == 0)
			{
				alert('NO BUSES!');
				res.redirect('/home');
			}
			else
			{
				req.session.buses = bus;
				res.redirect('/buses');
			}
		}
	}
	var result = example(from,to);
	//console.log(beta);
	//alert(day);
});

app.get('/logout', function(req,res){
	req.session.destroy();
	res.redirect('/home');
});

app.get('/buses', bussessionChecker, function(req,res){
	res.render('buses', {bus: req.session.buses, name: req.session.user});
});

app.post('/buses/:id', function(req,res){
	console.log('welcome:');
	console.log(req.params.id);
	res.redirect('/buses');
});

app.listen(8080);