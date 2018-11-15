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

//app.use(express.static('./assets'));

/*app.use(cookieParser());*/

var urlencodedParser = bodyParser.urlencoded({ extended: false })


// initialize express-session to allow us track the logged-in user across sessions.
app.use(session({
    key: 'user_sid',
    secret: 'somerandonstuffs',
    resave: true,
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

var checker = function(req,res,next){
	if(!req.session.user){
		res.redirect('/login');
	}
	else
	{
		next();
	}
}

app.get('/', function(req,res){
	res.redirect('/home');
})

app.get('/login',sessionChecker, function(req, res){
	console.log('Connected');
	res.render('login', {name: req.session.user});
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
							//alert('good job!');
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
	res.render('register', {name: req.session.user});
});

app.post('/register', urlencodedParser, function(req,res){
	var name = req.body.name;
	var username = req.body.username;
	var password = req.body.password;
	var gender = req.body.gender;
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
					database.connection.query('INSERT INTO USERS VALUES (? , ?, ?, ?, ?)',[username,name,password,1000000,gender],
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
		async function book(check){
			var alpha = await database.connection.query('SELECT * FROM BOOKING_HISTORY WHERE username = ?', [check], function(err, rows, fields){
				if(err) throw err;
				res.render('home',{name: check, stations: someVar, rows: rows});
			})
		}
		book(check);
	  }
	});
});



app.post('/home', urlencodedParser, function(req,res){
	//console.log(stations);
	//alert(stations);
	//console.log(req.body);
	if(req.session.buses)
	{
		delete req.session.buses;
		delete req.session.day;
		delete req.session.month;
		delete req.session.year;
	}
	if(req.session.busid)
		delete req.session.busid;
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
		var one = await database.connection.query('SELECT distance FROM STATION WHERE stn_id = ?', [alpha]);
		var two = await database.connection.query('SELECT distance FROM STATION WHERE stn_id = ?', [beta]);
		two = two[0].distance;
		one = one[0].distance;
		var distance = two-one;
		console.log("distance ", distance);
		req.session.way = 1;
		if(one>two)
		{
			req.session.way = 2;
			distance = distance*-1;
		}
		req.session.distance = distance;
		if(beta>alpha)
		{
			var bus = await database.connection.query('SELECT * FROM(SELECT * FROM (SELECT start_stn_id, start.bus_id, start.route, destination_stn_id from START as start inner join DESTINATION as destination on(start.bus_id = destination.bus_id and start.route = destination.route) ) as my WHERE start_stn_id<=? AND destination_stn_id>=?) AS ROUTES inner join BUSES ON ROUTES.bus_id = BUSES.bus_id', [alpha,beta]);
			console.log(bus);
			//var bus = await database.connection.query('SELECT * FROM BUSES WHERE bus_id IN (SELECT START.bus_id FROM START WHERE START.stn_id<=? AND START.bus_id IN (SELECT DESTINATION.bus_id FROM DESTINATION WHERE DESTINATION.stn_id>=?))', [alpha,beta]);
			if(bus.length == 0)
			{
				alert('NO BUSES!');
				res.redirect('/home');
			}
			else
			{
				req.session.buses = bus;
				//console.log(bus[0].bus_id);
				req.session.day = day;
				req.session.month = month;
				req.session.year = year;
				res.redirect('/buses');
			}
		}
		else
		{
			var bus = await database.connection.query('SELECT * FROM(SELECT * FROM (SELECT start_stn_id, start.bus_id, start.route, destination_stn_id from START as start inner join DESTINATION as destination on(start.bus_id = destination.bus_id and start.route = destination.route) ) as my WHERE start_stn_id>=? AND destination_stn_id<=?) AS ROUTES inner join BUSES ON ROUTES.bus_id = BUSES.bus_id', [alpha,beta]);
			//var bus = await database.connection.query('SELECT * FROM BUSES WHERE bus_id IN (SELECT START.bus_id FROM START WHERE START.stn_id<=? AND START.bus_id IN (SELECT DESTINATION.bus_id FROM DESTINATION WHERE DESTINATION.stn_id>=?))', [beta, alpha]);
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
	}
	var result = example(from,to);
	//console.log(beta);
	//alert(day);
});

app.get('/logout', function(req,res){
	req.session.destroy();
	res.redirect('/home');
});

app.get('/delete/:id', function(req,res){
	console.log(req.params.id);
	if(!req.session.user)
		res.redirect('/home');
	database.connection.query('SELECT username FROM BOOKING_HISTORY WHERE booking_id = ?', [req.params.id], function(err, rows,fields){
		if(err) throw err;
		if(rows.length==0 || rows[0].username!=req.session.user)
			res.redirect('/home');
		database.connection.query('DELETE FROM BOOKING_HISTORY WHERE booking_id = ?', [req.params.id], function(err){
			if(err) throw err;
		})
	})
	res.redirect('/home');
})

app.get('/buses', function(req,res){
	if(!req.session.buses)
		res.redirect('/home');
	if(req.session.busid)
		delete req.session.busid;
	res.render('buses', {bus: req.session.buses, name: req.session.user});
});

app.post('/buses/:id', function(req,res){
	//console.log(req.params.id);
	req.session.busid = req.params.id;
	console.log(req.params.id, req.session.busid);
	res.redirect('/seats');
});

app.get('/seats', function(req, res){
	if(!req.session.busid && req.session.buses) 
		res.redirect('/buses');
	if(!req.session.busid && !req.session.buses)
		res.redirect('/home');
	database.connection.query('SELECT ticket_id FROM BOOKING_HISTORY WHERE bus_id = ? AND day = ? AND month = ? AND year = ? AND way = ?', [req.session.busid, req.session.day, req.session.month, req.session.year, req.session.way], function(err, rows, fields){
		if(err) throw err;
		else
		{
			if(rows.length==30)
			{
				alert("Sorry all seats are full!");
				res.redirect('/seats/:id');
			}
			var result = [];
			for(var i=1; i<31; i++)
			{
				result.push(i);
			}
			for(var i=0; i<rows.length; i++)
			{
				var index = result.indexOf(rows[i].ticket_id);
				if (index > -1) {
				  result.splice(index, 1);
				}
			}
			res.render('seats', {result: result, name: req.session.user});
		}
	});
});

app.post('/seats', checker, urlencodedParser, function(req, res){
	var ticket = req.body.ticket;
	console.log(req.session.busid);
	database.connection.query('SELECT price_per_km FROM BUSES WHERE bus_id = ?', [req.session.busid], function(err, rows, fields){
		var price_per_km = rows[0].price_per_km;
		database.connection.query('SELECT wallet_balance FROM USERS WHERE username=?', [req.session.user], function(err,rows,fields){
			console.log(req.session.user);
			var wallet_balance = rows[0].wallet_balance;
			var price = price_per_km*req.session.distance;
			console.log(price_per_km, req.session.distance);
			console.log(wallet_balance, price);
			if(price>wallet_balance)
			{
				alert('Not enough money!');
			}
			else
			{
				async function haha(wallet_balance){
					console.log("check");
					for(var i=0; i<ticket.length; i++)
					{
						var x = await database.connection.query('INSERT INTO BOOKING_HISTORY VALUES (?,?,?,?,?,?,?,NULL)', [req.session.busid, req.session.day, req.session.month, req.session.year, ticket[i], req.session.user, req.session.way]);
					}
					console.log('this is so sad');
					var y = await database.connection.query('UPDATE USERS SET wallet_balance = ? WHERE username = ?', [wallet_balance-price, req.session.user]);
					res.redirect('/home');
				}
				haha(wallet_balance);
			}
		});
	});
});

app.listen(8080);