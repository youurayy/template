

    gulp = require 'gulp'
    coffee = require 'gulp-coffee'
    plumber = require 'gulp-plumber'
    concat = require 'gulp-concat'
    docco = require 'gulp-docco'
    sync = require('browser-sync').create()

    conf =
      dst: 'www'
      app: 'app.js'
      doc: 'doc'
      src: 'src/**/*.litcoffee'

    gulp.task 'coffee', ->
      gulp.src conf.src
        .pipe plumber()
        .pipe coffee()
        .pipe concat conf.app
        .pipe gulp.dest conf.dst

    gulp.task 'default', ['build'], ->
      sync.init
        server:
          baseDir: 'www'
          index: 'index.html'
        notify: false
        online: true
        minify: false
      gulp.watch conf.src, { interval: 1000 }, ['watch']

    gulp.task 'watch', ['coffee'], ->
      sync.reload()

    gulp.task 'docs', ->
      gulp.src conf.src
        .pipe docco
          layout: 'parallel' # http://jashkenas.github.io/docco/
        .pipe gulp.dest conf.doc

    gulp.task 'build', ['coffee', 'docs']
