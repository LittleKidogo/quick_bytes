const port = 9090
const express = require('express')
const fs = require('fs')
const path = require('path')
var app = express()

app.use(express.static('dist'))

app.get('*', (request, response, next) =>{
  response.sendFile(path.resolve('dist', 'index.html'))
})



const serveGzipped = contentType => (req, res, next) => {
  // does browser support gzip? does the file exist?
  const acceptedEncodings = req.acceptsEncodings()
  if (
    acceptedEncodings.indexOf('gzip') === -1
    || !fs.existsSync(`./build/${req.url}.gz`)
  ) {
    next()
    return
  }

  // update request's url
  req.url = `${req.url}.gz`

  // set correct headers
  res.set('Content-Encoding', 'gzip')
  res.set('Content-Type', contentType)

  // let express.static take care of the updated request
  next()
}

app.get('*.js', serveGzipped('text/javascript')) // !
app.get('*.css', serveGzipped('text/css')) // !

app.use(express.static('./build', {
  immutable : true,
  maxAge    : '1y' // caching!
}))


app.listen(port)

console.log(`Listen to requests on ${port}`)
