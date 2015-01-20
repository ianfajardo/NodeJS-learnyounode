fs = require('fs')
path = require('path')

fs.readdir process.argv[2], (err,files) -> (console.log file if (path.extname(file) == "." + process.argv[3])) for file in files
