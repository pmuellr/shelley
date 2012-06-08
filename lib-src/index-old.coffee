# Licensed under the Tumbolia Public License. See footer for details.

Backbone     = require "backbone"
attrx        = require "./attrx"
Meta         = require "./models/Meta"
Workspace    = require "./models/Workspace"

require "./persist/ModelLocalStorageSync"

#-------------------------------------------------------------------------------
shelley = module.exports = new class Shelley extends Backbone.Model

    #---------------------------------------------------------------------------
    toString: -> "#{@constructor.name}#{JSON.stringify(@attributes)}"
    
    #---------------------------------------------------------------------------
    attrx.declareAttributes @, 
        meta: type: [Meta]

    #---------------------------------------------------------------------------
    initialize: ->

        metaCollection = new Backbone.Collection null, model: @models.Meta
        metaCollection.storage = new LocalStorage name: "shelley.meta"
        
        @on "change:meta", (model, meta, options) ->
        
        metaCollection.fetch
            error:   unexpectedError
            success: (coll) => 
                if coll.length
                    @meta = coll.at 0
                    return
                    
                workspace = new Workspace
                    name: "default"
                    shells: []
                    
                @meta = new Meta
                    workspaces: ["default"]
                    currentWorkspace: "default"
                        
                    coll.add meta
                    @set "meta", meta

    #---------------------------------------------------------------------------
    getWorkspaces: () ->
        @workspaces.toArray()
    
    #---------------------------------------------------------------------------
    createWorkspace: (name) ->
        name = "#{name}"
        
        workspaces = @workspaces.where name: name
        return workspaces[0] if workspaces.length

        workspace = new Workspace 
            name: name
            
        @workspaces.add workspace
        
        workspace.save()
        
        workspace
    
    #---------------------------------------------------------------------------
    deleteWorkspace: (name) ->
        workspaces = @workspaces.where name: name
        return if !workspaces.length
        
        workspace = workspaces[0]
        
        @workspaces.remove workspace
        @workspaces.save()
        
        workspace
    
    #-------------------------------------------------------------------------------
    openWorkspace: (name, element) ->
    
    #-------------------------------------------------------------------------------
    registerShellModel: (name, cls) ->
        @shellModels[name] = cls
    
    #-------------------------------------------------------------------------------
    getShellModel: (name) ->
        @shellModels[name]

#-------------------------------------------------------------------------------
fetchedMetaCollection = (coll) ->
    shelley.
    shelley.set "meta", coll.at 0

#-------------------------------------------------------------------------------
unexpectedError = (e) -> 
    throw new Error "should not have errored with #{e}"
    

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
