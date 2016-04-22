'use strict';

var gulp = require('gulp'),
    sourcemaps = require('gulp-sourcemaps'),
    concat = require('gulp-concat'),
    jshint = require('gulp-jshint'),
    flatten = require('gulp-flatten'),
    ngAnnotate = require('gulp-ng-annotate'),
    uglify = require('gulp-uglify'),
    gls = require('gulp-live-server'),
    server;

// Default task : dev
gulp.task('default', ['dev']);

// Build app for release
gulp.task('build', ['copy', 'lint', 'uglify']);

// Developpement task : build and watch
gulp.task('dev', ['build', 'watch', 'server']);

// Watch for files changes
gulp.task('watch', function () {
    gulp.watch([
        './src/**/*.js',
        './assets/js/*.js'
    ], ['lint', 'uglify'])
        .on('change', notifyServer);
    
    gulp.watch([
        './src/**/*.html',
        './src/data/**'
    ], ['copy'])
        .on('change', notifyServer);
});

function notifyServer(file) {
    if(server) {
        server.notify.apply(server, [file]);
    }
}

// Starts HTTP server
gulp.task('server', function() {
   server = gls.static('dist', 1337);
   server.start();
});

// Copy required JS and HTML resources
gulp.task('copy', function() {
    // Libraries
    gulp.src([
        './bower_components/angular/angular.min.js'
    ])
        .pipe(gulp.dest('./dist/js/lib'));
    
    // Test data
    gulp.src([
        './src/data/**'
    ])
        .pipe(gulp.dest('./dist/data'));
    
    // Main page
    return gulp.src('./src/index.html')
        .pipe(gulp.dest('./dist'));
});

// JSHint
gulp.task('lint', function() {
  return gulp.src('./src/**/*.js')
    .pipe(jshint())
    .pipe(jshint.reporter('default'));
});

// Uglify app JS files
gulp.task('uglify', function() {
  return gulp.src([
      // Add modules declaration first
      './src/app/modules/*.js',
      // Then add others
      './src/**/*.js',
    ])
    //.pipe(sourcemaps.init())
    .pipe(concat('app.min.js'))
    //.pipe(uglify())
    //.pipe(ngAnnotate())
    //.pipe(sourcemaps.write('.'))
    .pipe(gulp.dest('./dist/js'));
});
