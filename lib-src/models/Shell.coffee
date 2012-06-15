# Licensed under the Tumbolia Public License. See footer for details.

Backbone = require "backbone"

attrx     = require "../attrx"

#-------------------------------------------------------------------------------
module.exports = class Shell extends require('backbone').Model

    #---------------------------------------------------------------------------
    attrx.declareAttributes @, 
        title:     type: String
        position:  type: [Number]
        size:      type: [Number]
        memento:   type: Object
        builder:  {type: Object,    transient: true}
        ws:       {type: Workspace, transient: true}

    #---------------------------------------------------------------------------
    initialize: (attrs) ->
        
        
    #---------------------------------------------------------------------------
    generateRandomPosition = (width, height) ->
        body = $(document.body)
        pWidth  = body.width()
        pHeight = body.height()
        
        x = Math.random() * (pWidth  - width  - 40)
        y = Math.random() * (pHeight - height - 40)
        
        x = Math.max(0, x)
        y = Math.max(0, y)
        
        [x, y]

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
