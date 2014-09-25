glob       = require 'glob'
path       = require 'path'
_          = require 'lodash'
proxyquire = require 'proxyquire'
callsite   = require 'callsite'
minimatch  = require 'minimatch'

resolveModulePath = (f) ->
  dirname = path.dirname f
  filename = path.basename f
  path.join dirname, filename

rewriteGlobs = (globs, ns) ->
  if typeof globs is "string" then path.join(ns, globs) else globs.map (g) -> path.join(ns, g)

gulpStub = (gulp, ns) ->
  tasks = []

  src: (globs, options) ->
    globPath = rewriteGlobs globs, ns
    gulp.src globPath, options
  dest: (p) ->
    gulp.dest path.join ns, p
  task: (name, deps, fn) ->
    unless fn
      fn = deps
      deps = []

    deps = deps.map (dep) ->
      path.join ns, dep

    fullName = path.join ns, name
    tasks.push {
      name
      ns
      fullName
    }
    gulp.task fullName, deps, fn
   watch: (globs, options, tasksOrCb) ->
     globPath = rewriteGlobs globs, ns
     unless tasksOrCb
       tasksOrCb = options
       options = undefined
     tasksOrCb = tasksOrCb.map((t) -> path.join ns, t) if tasksOrCb instanceof Array
     gulp.watch globPath, options, tasksOrCb
   tasks: tasks

module.exports = (gulp, basePath) ->
  basePath = "*/" unless basePath

  globPath = path.join basePath, "**/gulpfile.*"
  stack = callsite()
  rootPath = path.dirname stack[1].getFileName()

  _.chain glob.sync globPath, { nocase: true }
    .filter (f) ->
      minimatch f, '!**/node_modules/**/gulpfile.*'
    .flatten (f) ->
      ns = path.dirname f
      modulePath = resolveModulePath f
      stub = gulpStub gulp, ns
      modulePath = path.join rootPath, modulePath
      proxyquire modulePath, { gulp: stub }
      stub.tasks
    .groupBy 'name'
    .map (tasks, name) ->
      tfns = tasks.map (task) ->
        task.fullName
      gulp.task name, tfns
      name
    .value()
