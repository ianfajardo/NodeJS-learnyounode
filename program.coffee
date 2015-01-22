###Exercise 2: Parsing command line variables###
###
var args = process.argv;
var sum = 0;

for (var i = 2; i < args.length; i++){
  sum += Number(args[i]);
}
console.log(sum);
###

###Exercise 3; My First I/O ###
###
var args = process.argv;
var filename = args[2];

var fs = require('fs');

var buf = fs.readFileSync(filename);
var str = buf.toString();
//or var str = fs.readFileSync(process.argv[2], 'utf8');

var arr = str.split('\n');
console.log(arr.length-1);
###

###Exercise 4: My First Async I/O###
###
var fs = require('fs');

fs.readFile(process.argv[2], 'utf8', function(err, fileContents){
  console.log((fileContents.split('\n')).length-1);
});
###

###Excercise 5: Filtered LS###

###
fs = require('fs')
path = require('path')

fs.readdir process.argv[2], (err,files) -> (console.log file if (path.extname(file) == "." + process.argv[3])) for file in files
###

###Excercise 6: Make It Modular###
###

mymodule = require('./mymodule')
dir = process.argv[2]
extension = process.argv[3]

mymodule(dir, extension, (err,files) -> 

		console.error("error", err) if err

		console.log(file) for file in files

	)


###

###Excercise 7: HTTP client###
###
http = require('http')
url = process.argv[2]

http.get(url, (response)->
		response.setEncoding('utf8')
		response.on('data', console.log)
		response.on('error', console.error)
		true
	)
###

###Excercise 8: HTTP Collect###
###
http = require('http')
bl = require('bl')

url = process.argv[2]

http.get url, (response)->
	response.pipe( bl((err,data)-> 
			console.error(err) if err
			data = data.toString()
			console.log data.length 
			console.log data 
		))
###

### Excercise 9: HTTP Multiple ASYNC###

###
http = require('http')
bl = require('bl')
arr = new Array((process.argv.length)-2)

count = 0

httpGet = (index) ->( http.get process.argv[index+2], (response) ->

	response.pipe bl ((err,data) ->
			console.error(err) if err
			arr[index] = data.toString()
			count++
			(console.log(arr[_i]) for url_data in arr) if count == arr.length
		)
	
	true)

httpGet _i for index in arr
###

### Exercise 10: Time Server ###

###
net = require('net')
port = process.argv[2]
d = new Date

addZeroes = (d) -> 
	if d < 10
		return "0" + d
	else 
		return d

date = d.getFullYear() + "-" + addZeroes(d.getMonth() + 1)  + "-" + addZeroes(d.getUTCDate())  + " " + addZeroes d.getHours() + ":" + addZeroes d.getMinutes()

server = net.createServer (socket) -> 
	socket.write date + "\n"
	socket.end()
	true
	
server.listen Number port
###

###Exercise 11: HTTP File Server###
###
fs = require('fs')
http = require('http')

port = process.argv[2]
file = process.argv[3]

server = http.createServer (req, res) ->
	res.writeHead 200, { 'content-type': 'text/plain' }

	(fs.createReadStream file).pipe res


server.listen Number port
###

###Exercise 12: HTTP Uppercaser###
###
http = require('http')
map = require('through2-map')

port = process.argv[2]

server = http.createServer (req,res) ->

	if req.method == 'POST' 
		req.pipe(map((chunk)->
			return chunk.toString().toUpperCase()
			)).pipe res
	else
		res.end('not a POST')

	

server.listen Number port
###

###Exercise 13: HTTP JSON API Server###
http = require('http')
url = require('url')

getTime = (time) -> 
	obj = 
		hour: time.getHours()
		minute: time.getMinutes()
		second: time.getSeconds()

getUnixTime = (time) ->
	obj =
		unixtime: time.getTime()

port = process.argv[2]

server = http.createServer (req, res) ->
	parsedURL = url.parse(req.url, true)
	time = new Date parsedURL.query.iso

	if /^\/api\/parsetime/.test(req.url)
			result = getTime(time) 
	else if /^\/api\/unixtime/.test(req.url)
		result = getUnixTime(time)

	if result
		res.writeHead 200, { 'Content-Type': 'application/json'}
		res.end(JSON.stringify result)
	else
		res.writehead 404
		res.end()


server.listen Number port

