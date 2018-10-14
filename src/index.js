'use strict';

require('./index.html');
require('./style.css');
const {Elm} = require('./Main.elm');
const location =  window.location.pathname
console.log(location, 'this is the location')
var app = Elm.Main.init({
	node: document.getElementById('main'),
	flags: location
})



