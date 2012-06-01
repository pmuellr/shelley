# Licensed under the Tumbolia Public License. See footer for details.

jasmineEnv = jasmine.getEnv()
jasmineEnv.updateInterval = 1000

trivialReporter = new jasmine.TrivialReporter()

jasmineEnv.addReporter(trivialReporter)

jasmineEnv.specFilter = (spec) ->
    trivialReporter.specFilter(spec)

currentWindowOnload = window.onload

window.onload = ->
    if currentWindowOnload
        currentWindowOnload()
        
    execJasmine()

execJasmine = ->
    jasmineEnv.execute()

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
