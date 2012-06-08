# Licensed under the Tumbolia Public License. See footer for details.

Backbone = require "backbone"
_        = require "underscore"

#-------------------------------------------------------------------------------
# This model superclass simplifies attribute access, but "declaring"
# attributes, which then adds getters, setters, and validators
#-------------------------------------------------------------------------------
# example:
#    class Animal
#    
#        attrx.declareAttributes @, 
#            name: 
#                type: String
#            legs: 
#                type: Number
#            tail:
#                type: Boolean
#            colors:
#                type: [Color]
#-------------------------------------------------------------------------------
# To add attributes, use the single function declareAttributes, passing in the
# class to have the attributes added to it, and an object with the attributes
# to be added as properties of that object.
# 
# Each attribute is an object itself, and can have the following properties:
#   
#    type: a type descriptor used for validation
#
# Type is a "class" object, one of Object, Boolean, Number, String or a
# Backbone.Model class.  In addition, you can specify that object as a
# single element of a multi-dimensional array, indicating the type is an
# an array of those types. The class Object should be used to indicate 
# any type.
# 
# The type information is used in the setter created for the attribute.
# The an incorrectly typed value is attempted to be set, an exception will
# be thrown.
#
# The type information is also used, when Model classes are specified, to
# reconsistitute an attribute value as a model class, via parse().
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
# attrx exports a bag of functions
#-------------------------------------------------------------------------------
attrx = module.exports

#-------------------------------------------------------------------------------
# attrx.declareAttributes takes a model class, and object containing
# attributes to be declared on the model class.
#-------------------------------------------------------------------------------
attrx.declareAttributes = (modelClass, attrxAttrs) ->

    # loop through the attributes, add the setters/getters to the prototype
    # and collect the parse functions
    parseFns = []
    for key, val of attrxAttrs

        validator = getValidator val.type
        parser    = getParser    val.type, key
        
        parseFns.push  parser
        
        descriptor =
            configurable: true
            enumerable:   true
            get:          getGetter(key)
            set:          getSetter(key, validator)
        
        Object.defineProperty modelClass::, key, descriptor
        
    # set the model class's parse method
    modelClass::parse = getCompleteParser parseFns
    
    # set the model class's toJSON() method
    modelClass::toJSON = ->
        JSON.parse JSON.stringify @attributes
        
#-------------------------------------------------------------------------------
# return the getter function for a given attribute name
#-------------------------------------------------------------------------------
getGetter = (key) ->
    -> @get key
    
#-------------------------------------------------------------------------------
# return the setter function for a given attribute name
#-------------------------------------------------------------------------------
getSetter = (key, validator) ->
    (value) ->
        # validate the value
        if !validator.call(null, value)
            throw new Error "invalid value for attribute #{key}"
            
        @set key, value

#-------------------------------------------------------------------------------
# given parse functions for each attribute, return a function which calls them
#-------------------------------------------------------------------------------
getCompleteParser = (parseFns) ->
    return (attrs) ->
        return attrs if !attrs?
        
        for parseFn in parseFns
            attrs = parseFn.call(null, attrs)
            
        attrs

#-------------------------------------------------------------------------------
# get a parser for given type descriptor with the given attribute name
#-------------------------------------------------------------------------------
getParser = (descriptor, key) ->
    descriptor = Object if !descriptor

    if descriptor == Object
        return (attrs) -> attrs
        
    if _.isArray(descriptor)
        valueParser = getParser descriptor[0]
        useCollection = isModelType descriptor[0]
    
        return (attrs) ->
            return attrs if !attrs?
            arr = attrs[key]
            return attrs if !arr
            
            for i in [0 ... arr.length]
                arr[i] = valueParser arr[i]
                
            if useCollection
                collClass = Backbone.Collection.extend model: descriptor[0]
                attrs[key] = new collClass(arr)
                
            return attrs
        
    if descriptor == Boolean
        return (attrs) -> attrs
        
    if descriptor == Number
        return (attrs) -> attrs
        
    if descriptor == String
        return (attrs) -> attrs

    if descriptor == Date
        return (attrs) -> 
            return attrs if !attrs?
            dateString = attrs[key]
            return attrs if !dateString
        
            # 2011-10-10T14:48:00.000Z
            pattern = /(\d{4}).(\d{2}).(\d{2}).(\d{2}).(\d{2}).(\d{2})(.(\d*))?Z/
            match = dateString.match(pattern)
            if !match
                return attrs
                
            [crap1,yr,mo,da,hr,mi,se,crap2,ms] = match
            
            yr = parseInt yr, 10
            mo = parseInt mo, 10
            da = parseInt da, 10
            hr = parseInt hr, 10
            mi = parseInt mi, 10
            se = parseInt se, 10
            ms = parseInt ms, 10

            utcms = Date.UTC(yr, mo-1, da, hr, mi, se, ms)
            attrs[key] = new Date(utcms)
            
            return attrs
        
    if typeof descriptor != "function"
        return (attrs) -> attrs

    return (attrs) ->
        return attrs if !attrs?
        
        objAttrs = attrs[key]
        return attrs if !objAttrs
        
        attrs[key] = new descriptor(objAttrs)
        
        return attrs

#-------------------------------------------------------------------------------
# get a validator function for the given type descriptor
#-------------------------------------------------------------------------------
getValidator = (descriptor) ->
    descriptor = Object if !descriptor
    
    if descriptor == Object
        return (value) -> 
            true
    
    if _.isArray(descriptor)
        valueValidator = getValidator descriptor[0]
        
        return (values) -> 
            return true if !values?
            return false if !_.isArray(values)
            for value in values
                return false if !valueValidator.call(null, value)
            return true
        
    if descriptor == Boolean
        return (value) -> 
            return true if !value?
            typeof value == "boolean"
        
    if descriptor == Number
        return (value) -> 
            return true if !value?
            typeof value == "number"
        
    if descriptor == String
        return (value) -> 
            return true if !value?
            typeof value == "string"
        
    if descriptor == Date
        return (value) -> 
            return true if !value?
            value instanceof Date
        
    if typeof descriptor != "function"
        throw new Error "invalid validator"
        
    return (value) ->
        return true if !value?
        return value instanceof descriptor

#-------------------------------------------------------------------------------
isBaseType = (descriptor) ->
    switch descriptor
        when Object, Boolean, Number, String then return true
        else return false

#-------------------------------------------------------------------------------
isModelType = (descriptor) ->
    return false if typeof descriptor != "function"
    return false if isBaseType(descriptor)
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
