var path = require('path');
const CopyWebpackPlugin = require('copy-webpack-plugin')
const CompressionPlugin = require('compression-webpack-plugin');

const env = process.env.NODE_ENV

let debugMode  = {}

//set debugMode for application 
switch (env) {
	case "production":
		debugMode = { optimize: true }
    case "development":
		debugMode = { debug: true }
}

module.exports = {
  // If your entry-point is at "src/index.js" and
  // your output is in "/dist", you can ommit
  // these parts of the config
  module: {
	    rules: [{
        test: /\.html$/,
        exclude: /node_modules/,
        loader: 'file-loader?name=[name].[ext]'
      },
	  {
        test: /\.(css|scss)$/,
        use: [
          'style-loader',
          'css-loader',
        ]
      },
      {
        test: /\.elm$/,
        exclude: [/elm-stuff/, /node_modules/],
        // This is what you need in your own work
        loader: "elm-webpack-loader",
        options: debugMode,
      }
    ]
  },

  devServer: {
    inline: true,
    stats: 'errors-only'
  },
  plugins: [
    	new CompressionPlugin(),
	  	new CopyWebpackPlugin([{ from: 'src/images/', to: 'images/' }])
  ],
};

