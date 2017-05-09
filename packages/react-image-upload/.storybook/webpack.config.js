var path = require('path')

module.exports = {
  module: {
    loaders: [
      {
        test: /(.lsc)|(.lsx)$/,
        loaders: ["babel-loader"],
        include: path.resolve(__dirname, '../')
      }
    ]
  },
  resolve: {
    extensions: ["", ".js", ".jsx", ".lsc", ".lsx"]
  }
}
