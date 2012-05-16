# Licensed under the Tumbolia Public License. See footer for details.

shelley  = require 'shelley'

AboutShell = require './AboutShell'

#-------------------------------------------------------------------------------
main = ->
    $('#button-open-about-shell').click onClick
    
    shelley.setWorkspace('shelley-samples-about')
    shelley.restoreWorkspace()

#-------------------------------------------------------------------------------
onClick = ->
    shelley.createShell AboutShell,
        persistent:         true
        persistentSize:     true
        persistentPosition: false
        
    alert('you clicked me!')
    
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
