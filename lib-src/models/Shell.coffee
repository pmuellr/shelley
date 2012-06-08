# Licensed under the Tumbolia Public License. See footer for details.

Backbone = require "backbone"
_        = require "underscore"

attrx = require "../attrx"

#-------------------------------------------------------------------------------
module.exports = class Shell extends Backbone.Model

    #---------------------------------------------------------------------------
    toString: -> "#{@constructor.name}#{JSON.stringify(@attributes)}"
    
    #---------------------------------------------------------------------------
    attrx.declareAttributes @, 
        position:       type: [Number]
        size:           type: [Number]
        shellModel:     type: String
        memento:        type: Object


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
