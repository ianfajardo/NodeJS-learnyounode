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

http = require('http')
url = process.argv[2]

http.get(url, (response)->
		response.setEncoding('utf8')
		response.on('data', console.log)
		response.on('error', console.error)
		true
	)



