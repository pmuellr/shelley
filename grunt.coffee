# Licensed under the Tumbolia Public License. See footer for details.

fs   = require "fs"
path = require "path"

coffee        = require "coffee-script"
child_process = require "child_process"

sourceFiles = [
    "bin-src/**/*.coffee"
    "lib-src/**/*.coffee"
    "test-src/**/*.coffee"
    "test-src/**/*.html"
    "samples/**/*.coffee"
    "samples/**/*.html"
    "package.cson"
    "Makefile"
]

#-------------------------------------------------------------------------------
module.exports = (grunt) ->

    #---------------------------------------------------------------------------
    grunt.initConfig
        watch:
            gruntjs:
                files: ["grunt.coffee"]
                tasks: ["gruntjs"]
            make:
                files: sourceFiles
                tasks: ["make"]
    
    #---------------------------------------------------------------------------
    grunt.registerTask "default", "watch"
    
    #---------------------------------------------------------------------------
    grunt.registerTask "gruntjs", "convert grunt.coffee to grunt.js", ->
        jFileName = path.join __dirname, "grunt.js"
        cFileName = path.join __dirname, "grunt.coffee"
        
        jStat = fs.statSync jFileName
        cStat = fs.statSync cFileName
        
        jmTime = jStat.mtime
        cmTime = cStat.mtime
        
        if cmTime < jmTime
            grunt.verbose.writeln "grunt.js newer than grunt.coffee, skipping compile"
            return
        
        cSource = fs.readFileSync cFileName, "utf-8"
        
        try 
            jSource = coffee.compile cSource, 
                bare: true
        catch e
            grunt.error e
            
        fs.writeFileSync jFileName, jSource, "utf-8"
        
        grunt.log.writeln "compiled #{cFileName} to #{jFileName}"

    #---------------------------------------------------------------------------
    grunt.registerTask "make", "run make", ->
        
        done = @async()
        
        make = child_process.spawn 'make'
        
        make.stdout.on "data", (data) ->
            grunt.log.write "#{data}"
        
        make.stderr.on "data", (data) ->
            grunt.log.error "#{data}"
        
        make.on "exit", (code) ->
            if code == 0
                done(true) 
                return
            
            grunt.log.writeln "error running make", code
            done(false)

#-------------------------------------------------------------------------------
# Copyright (c) 2012 Patrick Mueller
# 
# Tumbolia Public License
# 
# Copying and distribution of this file, with or without modification, are
# permitted in any medium without royalty provided the copyright notice and this
# notice are preserved.
# 
# TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
# 
#   0. opan saurce LOL
#-------------------------------------------------------------------------------
