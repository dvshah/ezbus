var express = require('express');
var http = require('http');
var bodyParser = require('body-parser');
var database = require('./database');
var alert = require('alert-node');
var qs = require('querystring');
var cookieParser = require('cookie-parser');
var session = require('express-session');
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
})

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
})



app.post('/home', urlencodedParser, function(req,res){
	//console.log(stations);
	//alert(stations);
	console.log(req.body);
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
	//console.log(station);
	res.redirect('/home');
	//alert(day);
})

app.get('/logout', function(req,res){
	req.session.destroy();
	res.redirect('/home');
})

app.listen(8080);