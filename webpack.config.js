const path = require('path');
const webpack = require('webpack');

const ExtractTextPlugin = require('extract-text-webpack-plugin');

const extractSass = new ExtractTextPlugin({
    filename: "[name].[contenthash].css"
});

module.exports = {
  context: path.resolve(__dirname, 'src/js'),
  entry: {
    app: './app.js'
  },
  output: {
    path: path.resolve(__dirname, 'wwwroot/assets/bundles'),
    filename: '[name].js',
  },
  module: {
    rules: [
        {
          test: /\.woff2?$|\.ttf$|\.eot$|\.svg$/,
          loader: 'file-loader'
        },
        {
            test: /\.(png|jp(e*)g|svg)$/,
            use: [{
                loader: 'url-loader',
                options: {
                    limit: 8000, // Convert images < 8kb to base64 strings
                    name: '[hash]-[name].[ext]'
                }
            }]
        },
      {
        test:/\.(s*)css$/,
        use: ExtractTextPlugin.extract({
            fallback:'style-loader',
            use:['css-loader','sass-loader'],
        })
      },
      {
          // Exposes jQuery for use outside Webpack build
          test: require.resolve('jquery'),
          use: [{
              loader: 'expose-loader',
              options: 'jQuery'
          }, {
              loader: 'expose-loader',
              options: '$'
          }]
      }
    ]
  },
  plugins: [
    new webpack.ProvidePlugin({
        $: 'jquery',
        jQuery: 'jquery'
    }),
    new ExtractTextPlugin({filename:'[name].css'})
  ]
};