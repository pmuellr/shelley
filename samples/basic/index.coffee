# Licensed under the Tumbolia Public License. See footer for details.

shelley  = require 'shelley'

#-------------------------------------------------------------------------------
main = ->
    $('#button-open-closeable-shell').click   openCloseableShell
    $('#button-open-uncloseable-shell').click openUncloseableShell
    $('#button-open-modal-shell').click       openModalShell

#-------------------------------------------------------------------------------
openCloseableShell = ->
    content = $("<div>")
    content.html "<p>opened at: #{Date()}"
    
    shell = shelley.createShell 
        title:     "closeable shell"
        element:   content
    
    shell.open()
    
#-------------------------------------------------------------------------------
openUncloseableShell = ->
    content = $("<div>")
    content.html "<p>opened at: #{Date()}"
    
    shell = shelley.createShell 
        title:     "uncloseable shell"
        closeable: false
        element:   content
    
    shell.open()
    
#-------------------------------------------------------------------------------
openModalShell = ->
    shell = shelley.createShell 
        title:     "modal shell"
        modal:     true
        element:   $("#modal-shell")
    
    # always auto-opens
    # shell.open()
    
    
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
