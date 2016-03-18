module.exports = {
  context: __dirname + "/app/assets/javascripts",
  entry: "./main.js",
  output: {
    path: __dirname + "/app/assets/javascripts",
    filename: "./build/main.js"
  },
  module: {
    loaders: [
      {
        test: /\.js$/,
        exclude: /node_modules/,
        loader: "babel-loader",
        query: {
          presets: ['es2015']
        }
      }
    ]
  },
  devtool: 'inline-source-map',
  watch: true
};
