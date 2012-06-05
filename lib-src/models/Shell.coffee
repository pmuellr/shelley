# Licensed under the Tumbolia Public License. See footer for details.

Backbone = require "backbone"
_        = require "underscore"

#-------------------------------------------------------------------------------
# attributes
#-------------------------------------------------------------------------------
#   position:   [Number, Number]
#   size:       [Number, Number]
#   shellModel: String
#   memento:    Object
#-------------------------------------------------------------------------------

module.exports = class Shell extends Backbone.Model

    #---------------------------------------------------------------------------
    toString: -> "#{@constructor.name}#{JSON.stringify(@attributes)}"
    
    #---------------------------------------------------------------------------
    validate: (attributes) ->
        
        position = attributes.position
        if position
            if !_.isArray(position)
                return new Error "position must be an array"
            
            if position.length != 2
                return new Error "position must be an array of length 2"
    
            if typeof position[0] != "number"
                return new Error "position[0] must be a number"
    
            if typeof position[1] != "number"
                return new Error "position[1] must be a number"
    
        size = attributes.size
        if size
            if !_.isArray(size)
                return new Error "size must be an array"
            
            if size.length != 2
                return new Error "size must be an array of length 2"
    
            if typeof size[0] != "number"
                return new Error "size[0] must be a number"
    
            if typeof size[1] != "number"
                return new Error "size[1] must be a number"

        shellClass = attributes.shellClass
        if shellClass
            if typeof shellClass != "string"
                return new Error "shellClass must be a string"

        memento = attributes.memento
        if memento
            try 
                JSON.stringify memento
            catch e
                return e
    

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
