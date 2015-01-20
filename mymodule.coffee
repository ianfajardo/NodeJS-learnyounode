fs = require('fs')
path = require('path')
arr = []

module.exports = (dir, filterStr, callback) -> fs.readdir dir, (err,files) -> 

	return callback(err) if err

	(( arr.push file if (path.extname(file) == "." + filterStr)) for file in files)

	callback null, arr

