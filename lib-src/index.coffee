# Licensed under the Tumbolia Public License. See footer for details.

Backbone     = require "backbone"
LocalStorage = require "./persist/LocalStorage"
StorageSync  = require "./persist/StorageSync"
expando      = require "./expando"
Workspace    = require './models/Workspace'

Backbone.sync = StorageSync.sync

#-------------------------------------------------------------------------------
shelley = module.exports = new class Shelley extends Backbone.Model

    #---------------------------------------------------------------------------
    initialize: ->
        @shellModels = {}
        
        @models = 
            Shell:        require "./models/Shell"
            Workspace:    require "./models/Workspace"
            Meta:         require "./models/Meta"    

        metaCollection = new Backbone.Collection null, model: @models.Meta
        metaCollection.storage = new LocalStorage name: "shelley.meta"
        
        @on "change:meta", (model, meta, options) ->
            meta.get            
        
        metaCollection.fetch
            error:   unexpectedError
            success: (coll) => 
                if coll.length
                    @set "meta", coll.at 0
                else
                    meta = new @models.Meta
                        workspaces: []
                        currentWorkspace: "default"
                        
                    coll.add meta
                    @set "meta", meta

    #---------------------------------------------------------------------------
    declareAttributes: expando.declareAttributes

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
