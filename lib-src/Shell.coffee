# Licensed under the Tumbolia Public License. See footer for details.

Backbone = require 'backbone'

#-------------------------------------------------------------------------------

module.exports = Shell = Backbone.Model.extend

    #---------------------------------------------------------------------------
    initialize: (attributes) ->
    
    #---------------------------------------------------------------------------
    defaults:
        persist:         false
        persistPosition: false
        persistSize:     false
    

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
