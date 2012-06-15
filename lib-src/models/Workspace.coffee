# Licensed under the Tumbolia Public License. See footer for details.

Backbone = require "backbone"

attrx = require "../attrx"

Shell = require "./Shell"

#-------------------------------------------------------------------------------
module.exports = class Workspace extends require('backbone').Model

    #---------------------------------------------------------------------------
    attrx.declareAttributes @, 
        name:   type: String
        shells: type: [Shell]

    #---------------------------------------------------------------------------
    open: (element) ->

    #---------------------------------------------------------------------------
    close: ->

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
