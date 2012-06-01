# Licensed under the Tumbolia Public License. See footer for details.

#-------------------------------------------------------------------------------
# Storage class that uses window.localStorage
#-------------------------------------------------------------------------------

module.exports = class LocalStorage extends require("./Storage")

    _ = require "underscore"
    
    #-------------------------------------------------------------------------------
    initialize: (options) ->
        @name   = options.name
        
        if !@name
            throw new Error "no name specified"
            
        @_load()
    
    #-------------------------------------------------------------------------------
    create: (collection, model) ->
        if !model.id 
            model.id = model.attributes.id = @data.nextID
            @data.nextID++
            
        @data.items[model.id] = model

        return @_save(model)
    
    #-------------------------------------------------------------------------------
    read: (collection, model) ->
        model = @data.items[model.id]
        
        if model
            return [null, model]
        else
            return ["not found", null]
    
    #-------------------------------------------------------------------------------
    readAll: (collection) ->
        result = _.values(@data.items)    

        return [null, result]
    
    #-------------------------------------------------------------------------------
    update: (collection, model) ->
        @data.items[model.id] = model

        return @_save(model)
    
    #-------------------------------------------------------------------------------
    delete: (collection, model) ->
        delete @data.items[model.id]

        return @_save(model)

    #-------------------------------------------------------------------------------
    _save: (result) ->
        try 
            window.localStorage.setItem @name, JSON.stringify(@data)
            return [null, result]
        catch e
            return ["#{e}", null]
    
    #-------------------------------------------------------------------------------
    _load: ->
        data = window.localStorage.getItem @name
        
        if data
            @data = JSON.parse(data)
            
        else
            @data =
                nextID: 0
                items:  {}
                
            @_save()
    
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
