const { purgeCSSPlugin } = require('@fullhuman/postcss-purgecss')
const autoprefixer = require('autoprefixer')

const inProd = process.env.NODE_ENV === 'production'

module.exports = {
  plugins: [
  autoprefixer,
    ...(inProd ? [
      purgeCSSPlugin({
        content: [
          './_site/**/*.html',        // built pages
          './_includes/**/*.html',    // templating
          './_layouts/**/*.html',
          './**/*.md',                // Markdown fronts
          './assets/js/**/*.js'       // JS that injects classes
        ],
        safelist: {
          standard: [
            /^modal/, /^collapse/, /^show/, /^carousel/, /^tooltip/,
            /^dropdown/, /^fade/, /^alert/
          ]
        }
      })
    ] : [])
  ]
}
