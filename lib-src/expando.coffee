# Licensed under the Tumbolia Public License. See footer for details.

Backbone = require "backbone"
_        = require "underscore"

#-------------------------------------------------------------------------------
# This model superclass simplifies attribute access, but "declaring"
# attributes, which then adds getters, setters, and validators
#-------------------------------------------------------------------------------
# example:
#    class Animal extends ExpandoModel
#    
#        ExpandoModel.declareAttributes @, 
#            name: 
#                type: String
#            legs: 
#                type: Number
#            tail:
#                type: Boolean
#            colors:
#                type: [String]
#         
#-------------------------------------------------------------------------------

expando = module.exports

expando.declareAttributes = (modelClass, expandoAttrs) ->
        for key, val of expandoAttrs
            descriptor =
                configurable: true
                enumerable:   true
                get:          getGetter(key)
                set:          getSetter(key)
            
            Object.defineProperty modelClass::, key, descriptor
            
        modelClass::validate = getValidator(expandoAttrs)
        
#-------------------------------------------------------------------------------
getGetter = (key) ->
    -> @.get key
    
#-------------------------------------------------------------------------------
getSetter = (key) ->
    (value) -> @.set key, value,
        error: (e) -> throw e
    
#-------------------------------------------------------------------------------
getValidator = (expandoAttrs) -> 
    (attrs) ->
        for attrKey, attrVal of attrs
            expandoAttr = expandoAttrs[attrKey]
            continue if !expandoAttr
            
            result = validate attrKey, attrVal, expandoAttr
            
            return result if result
                
#-------------------------------------------------------------------------------
validate = (name, value, expandoAttr) ->
    if _.isArray(expandoAttr.type) 
        if !_is.Array(value)
            return new Error "expecting an array for #{name}"
        
        if !validateBasicType name, value[0], expandoAttr.type[0]
            return new Error "invalid value for #{name}"
            
        return
        
    if !validateBasicType name, value, expandoAttr.type
        return new Error "invalid value for #{name}"

    return    

#-------------------------------------------------------------------------------
validateBasicType = (name, value, cls) ->

    if (cls == String)
        return typeof value == "string"
        
    if (cls == Boolean)
        return typeof value == "boolean"
    
    if (cls == Number)
        return typeof value == "number"

    if (cls == Object)
        return typeof value == "object"
        
    return true
    
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
