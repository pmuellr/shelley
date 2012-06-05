# Licensed under the Tumbolia Public License. See footer for details.

shelley  = require 'shelley'

#-------------------------------------------------------------------------------
main = ->
    $('#button-open-shell').click openShell
    
    shelley.registerShellModel "hello.world", HelloWorldShell
    
    shelley.ws.open()
    

#-------------------------------------------------------------------------------
class HelloWorldShell extends shelley.models.Shell
    
    #---------------------------------------------------------------------------
    initialize: (attrs) ->
    
    #---------------------------------------------------------------------------
    createContent: ->
        content = $("<div>")
        content.html "<p>Hello, World! <p>opened at: #{@get('date')}"

        return content[0]        

#-------------------------------------------------------------------------------
openShell = ->
    shelley.createShell "hello.world", 
        date: Date()
    
#-------------------------------------------------------------------------------
$(document).ready(main)

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
