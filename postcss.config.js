const purgecss = require('@fullhuman/postcss-purgecss')

const inProd = process.env.NODE_ENV === 'production'

module.exports = {
  plugins: [
    require('autoprefixer'),
    ...(inProd ? [
      purgecss({
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
