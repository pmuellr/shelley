# Licensed under the Tumbolia Public License. See footer for details.

Backbone = require "backbone"
_        = require "underscore"
Shell    = require "./Shell"

module.exports = class Workspace extends Backbone.Model

    #---------------------------------------------------------------------------
    toString: -> "#{@constructor.name}#{JSON.stringify(@attributes)}"

    #---------------------------------------------------------------------------
    validate: (attributes) ->
        
        name = attributes.name
        if name
            if typeof name != "string"
                return new Error "name must be a string"

    #---------------------------------------------------------------------------
    toJSON: ->
        attrs = _.clone(@attributes)
        
        if attrs.shells
            attrs.shells = attrs.shells.toJSON()
            
        attrs
        
    #---------------------------------------------------------------------------
    parse: (response) ->
        shells = response.shells
        shells = new Backbone.Collection shells, model: Shell
        
        response.shells = shells
        response

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
