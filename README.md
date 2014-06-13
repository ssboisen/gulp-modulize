# gulp-modulize 
> Modulizing the streaming build system

## Documentation

Comming!

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
