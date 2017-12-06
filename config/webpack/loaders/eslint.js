module.exports = {
  test: /\.(js|vue)$/,
  loader: 'eslint-loader',
  enforce: 'pre',
  fix: true,
  options: {
    formatter: require('eslint-friendly-formatter')
  }
}
