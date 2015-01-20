###xcercise 5: Filtered LS###

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
