'use strict';

var gulp = require('gulp'),
    sourcemaps = require('gulp-sourcemaps'),
    concat = require('gulp-concat'),
    jshint = require('gulp-jshint'),
    flatten = require('gulp-flatten'),
    ngAnnotate = require('gulp-ng-annotate'),
    uglify = require('gulp-uglify');

// Default task for development : build and watch
gulp.task('default', ['build', 'watch']);

// Build app for release
gulp.task('build', ['copy', 'lint', 'uglify']);

// Watch for files changes
gulp.task('watch', function () {
    gulp.watch(['./src/**/*.js', './assets/js/*.js'], ['lint', 'uglify']);
    gulp.watch('./src/**/*.html', ['copy']);
});

// Copy required JS and HTML resources
gulp.task('copy', function() {
    // Libraries
    gulp.src([
        './bower_components/angular/angular.min.js'
    ])
        .pipe(gulp.dest('./dist/js/lib'));
    
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
  gulp.src('./assets/js/*.js')
    .pipe(gulp.dest('./dist/js/lib'));

  return gulp.src('./src/**/*.js')
    .pipe(sourcemaps.init())
      .pipe(concat('app.min.js'))
    .pipe(uglify())
    .pipe(ngAnnotate())
    .pipe(sourcemaps.write('.'))
    .pipe(gulp.dest('./dist/js'));
});
