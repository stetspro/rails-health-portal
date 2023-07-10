const path = require('path');

module.exports = {
  mode: 'development',
  entry: './app/javascript/packs/application.js',
  output: {
    filename: 'bundle.js',
    path: path.resolve(__dirname, 'dist'),
  },
};
