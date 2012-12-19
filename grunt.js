// Licensed under the Tumbolia Public License. See footer for details.

var fs   = require "fs"
var path = require "path"

var child_process = require "child_process"

//------------------------------------------------------------------------------
var sourceFiles = [
    "lib/**/*.js"
    "Makefile"
]

//------------------------------------------------------------------------------
var gruntConfig = {
    watch: {
        make: {
            files: sourceFiles,
            tasks: ["make"]
        }
    }
}

//------------------------------------------------------------------------------
function task_make() {
    var done = this.async()

    var make = child_process.spawn('make')

    make.stdout.on("data", function (data) {
        grunt.log.write(data)
    })

    make.stderr.on("data", function(data) {
        grunt.log.error(data)
    })

    make.on("exit"), function(code) {
        if (code == 0) {
            done(true)
            return
        }

        grunt.log.writeln("error running make: ", code)
        done(false)
    })
}

//------------------------------------------------------------------------------
module.exports = function(grunt) {
    grunt.initConfig(gruntConfig)
    grunt.registerTask("default", "watch")
    grunt.registerTask("make",    "run make", task_make)
}

//------------------------------------------------------------------------------
// Copyright (c) 2012 Patrick Mueller
//
// Tumbolia Public License
//
// Copying and distribution of this file, with or without modification, are
// permitted in any medium without royalty provided the copyright notice and this
// notice are preserved.
//
// TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
//
//   0. opan saurce LOL
//------------------------------------------------------------------------------
