# gulp-modulize 
> Modulizing the streaming build system

## What it does

gulp-modulize helps you work with modulized gulpfiles by importing tasks from gulpfiles located in subdirectories into a common gulpfile typically located in the root of your project directory.

This allow you to have seperate gulpfiles defined for each submodule in your application and at the same time have a common project-wide gulpfile that helps you run all tasks across modules. It does this in such a way that each of the submodules can have its own regular gulp workflow by defining new tasks that are specific for that submodule and running those tasks with gulp <taskname>.

## Documentation

### gulpModulize(gulp[, glob])

Runs gulp-modulize using the passed instance of gulp

#### gulp
Type: `Gulp`

An instance of the Gulp constructor-function as retrieved using require('gulp')

#### glob
Type: `String`

Optional base-glob to use when searching for gulpfiles. Default value is `*/`. The base-glob-path is joined with `**/gulpfile.*`.

## Sample `gulpfile.js`

```javascript
var gulp = require('gulp');
var gulpModulize = require('gulp-modulize');
var tasks = gulpModulize(gulp);

gulp.task('default', tasks);
```
## Sample `my_awesome_module/gulpfile.js`
```javascript
var gulp = require('gulp'),
var gutil = require('gulp-util');

gulp.task('test', function () {
	gutil.log('running tests');
});
```

## Want to contribute?

Anyone can help make this project better - pull-requests are very much welcome!
