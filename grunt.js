var child_process, coffee, fs, path, sourceFiles;

fs = require("fs");

path = require("path");

coffee = require("coffee-script");

child_process = require("child_process");

sourceFiles = ["bin-src/**/*.coffee", "lib-src/**/*.coffee", "test-src/**/*.coffee", "test-src/**/*.html", "samples/**/*.coffee", "samples/**/*.html", "package.cson", "Makefile"];

module.exports = function(grunt) {
  grunt.initConfig({
    watch: {
      gruntjs: {
        files: ["grunt.coffee"],
        tasks: ["gruntjs"]
      },
      make: {
        files: sourceFiles,
        tasks: ["make"]
      }
    }
  });
  grunt.registerTask("default", "watch");
  grunt.registerTask("gruntjs", "convert grunt.coffee to grunt.js", function() {
    var cFileName, cSource, cStat, cmTime, jFileName, jSource, jStat, jmTime;
    jFileName = path.join(__dirname, "grunt.js");
    cFileName = path.join(__dirname, "grunt.coffee");
    jStat = fs.statSync(jFileName);
    cStat = fs.statSync(cFileName);
    jmTime = jStat.mtime;
    cmTime = cStat.mtime;
    if (cmTime < jmTime) {
      grunt.verbose.writeln("grunt.js newer than grunt.coffee, skipping compile");
      return;
    }
    cSource = fs.readFileSync(cFileName, "utf-8");
    try {
      jSource = coffee.compile(cSource, {
        bare: true
      });
    } catch (e) {
      grunt.error(e);
    }
    fs.writeFileSync(jFileName, jSource, "utf-8");
    return grunt.log.writeln("compiled " + cFileName + " to " + jFileName);
  });
  return grunt.registerTask("make", "run make", function() {
    var done, make;
    done = this.async();
    make = child_process.spawn('make');
    make.stdout.on("data", function(data) {
      return grunt.log.write("" + data);
    });
    make.stderr.on("data", function(data) {
      return grunt.log.error("" + data);
    });
    return make.on("exit", function(code) {
      if (code === 0) {
        done(true);
        return;
      }
      grunt.log.writeln("error running make", code);
      return done(false);
    });
  });
};
