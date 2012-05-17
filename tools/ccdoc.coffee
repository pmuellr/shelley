#!/usr/bin/env coffee

# Licensed under the Tumbolia Public License. See footer for details.

fs = require "fs"

#-------------------------------------------------------------------------------
main = ->
    files = process.argv.slice 2
    
    lines = []
    for file in files
         getLines file, lines
        
    for line in lines
        console.log line
        

#-------------------------------------------------------------------------------
getLines = (fileName, result) ->
    try
        lines = fs.readFileSync fileName, "utf8"
    catch e
        console.error "skipping file #{fileName}: #{e}"
        return result
        
    lines   = lines.split "\n"
    pattern = /^\s*#@((\s*$)|(\s(.*)))/
    
    for line in lines
        match = line.match(pattern)
        continue if !match
        
        
        result.push match[4] || " "
        

#-------------------------------------------------------------------------------
main()

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
