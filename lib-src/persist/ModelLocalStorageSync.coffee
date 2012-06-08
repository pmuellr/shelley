# Licensed under the Tumbolia Public License. See footer for details.

#-------------------------------------------------------------------------------
# provides a replacement for Backbone.sync
#-------------------------------------------------------------------------------
# install:
#    Backbone.sync = <module>.sync
#-------------------------------------------------------------------------------
# use:
#    var library = new Backbone.Collection(null, {model: Book})
#    library.storage = new LocalStorageStore({key: "persist-key"})
#    library.fetch({success:function(){}, error:function(){}})
#    library.fetch({success:function(){}, error:function(){}})
#    
#-------------------------------------------------------------------------------

Backbone = require "backbone"
_        = require "underscore"

#-------------------------------------------------------------------------------
ModelLocalStorageSync = module.exports

#-------------------------------------------------------------------------------
# given a name, returns a Backbone.sync replacement using LocalStorage
#-------------------------------------------------------------------------------
ModelLocalStorageSync.sync = (name) ->
    if !name
        throw new Error "no name specified"

    return (method, model, options) ->

        # fill in the default options
        options = _.defaults _.clone(options),
            error:   (model, e) -> console.log "error sync #{method}: #{e}"
            success: (model, attrs) -> 
        
        # call the storage method                
        syncer[method].call(syncer, name, model, options)
        
#-------------------------------------------------------------------------------
syncer = 
    
    #-------------------------------------------------------------------------------
    create: (name, model, options) ->
        if !model.id 
            model.id = model.attributes.id = 0
            
        @_save(name, model, options)
    
    #-------------------------------------------------------------------------------
    read: (name, model, options) ->
        @_load(name, model, options)
    
    #-------------------------------------------------------------------------------
    update: (name, model, options) ->
        @_save(name, model, options)
    
    #-------------------------------------------------------------------------------
    delete: (name, model, options) ->
        @_delete(name, model, options)

    #-------------------------------------------------------------------------------
    _save: (name, model, options) ->
        try 
            attrs = model.toJSON()
            window.localStorage.setItem name, JSON.stringify(attrs)
            asyncCall options.success, model, attrs
        catch e
            asyncCall options.error,   model, e
    
    #-------------------------------------------------------------------------------
    _load: (name, model, options) ->
        try 
            attrs = window.localStorage.getItem name
            if null == attrs
                asyncCall options.success, model, model.toJSON()
                return
                
            attrs = JSON.parse(attrs)
            asyncCall options.success, attrs, null
        catch e
            asyncCall options.error,   model, e

    #-------------------------------------------------------------------------------
    _delete: (name, model, options) ->
        try 
            attrs = model.toJSON()
            window.localStorage.removeItem name
            asyncCall options.success, model, attrs
        catch e
            asyncCall options.error,   model, e
            
#-------------------------------------------------------------------------------
asyncCall = (fn, arg1, arg2) ->
    setTimeout((-> fn(arg1, arg2)), 0)
    
    
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
