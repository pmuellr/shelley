# Licensed under the Tumbolia Public License. See footer for details.

Backbone = require "backbone"
_        = require "underscore"

Shell    = require "./Shell"
attrx = require "../attrx"

#-------------------------------------------------------------------------------
module.exports = class Workspace extends Backbone.Model

    #---------------------------------------------------------------------------
    toString: -> "#{@constructor.name}#{JSON.stringify(@attributes)}"

    #---------------------------------------------------------------------------
    attrx.declareAttributes @, 
        name:   type: String
        shells: type: [Shell]
        
    #---------------------------------------------------------------------------
    @create = (name) ->
        coll         = new Backbone.Collection null, model: Workspace
        coll.storage = new LocalStorage name: "shelley.ws.#{name}"
        
    #---------------------------------------------------------------------------
    @get = (name) ->
        coll         = new Backbone.Collection null, model: Workspace
        coll.storage = new LocalStorage name: "shelley.ws.#{name}"
    
    

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
