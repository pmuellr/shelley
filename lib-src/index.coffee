# Licensed under the Tumbolia Public License. See footer for details.

module.exports = new class Shelley

    Backbone     = require "backbone"
    LocalStorage = require "./persist/LocalStorage"
    StorageSync  = require "./persist/StorageSync"
    
    Backbone.sync = StorageSync.sync
    
    Workspace = require './models/Workspace'

    #-------------------------------------------------------------------------------
    constructor: ->
        @shellClasses = {}
        
        @workspaces = new Backbone.Collection null, model: Workspace
        @workspaces.storage = new LocalStorage name:"shelley.workspaces"

    #-------------------------------------------------------------------------------
    getWorkspaces: () ->
        @workspaces.toArray()
    
    #-------------------------------------------------------------------------------
    createWorkspace: (name) ->
        name = "#{name}"
        
        workspaces = @workspaces.where name: name
        return workspaces[0] if workspaces.length

        workspace = new Workspace 
            name: name
            
        @workspaces.add workspace
        
        workspace.save()
        
        workspace
    
    #-------------------------------------------------------------------------------
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
    registerShellClass: (name, cls) ->
        @shellClasses[name] = cls
    
    #-------------------------------------------------------------------------------
    getShellClass: (name) ->
        @shellClasses[name]
    

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
