# Licensed under the Tumbolia Public License. See footer for details.

Backbone = require "backbone"

attrx   = require "./attrx"
Storage = require "./persist/ModelLocalStorageSync"

Workspace        = require "./models/Workspace"
WorkspaceManager = require "./models/WorkspaceManager"
Shell            = require "./models/Shell"

#-------------------------------------------------------------------------------
shelley = module.exports

#-------------------------------------------------------------------------------
main = ->
    wm = shelley.wm = new WorkspaceManager()
    wm.sync = Storage.sync "shelley.wm"
    
    wmFetchedCB = (model, attrs) -> 
        if !wm.workspaceNames
            wm.workspaceNames = []
            wm.save()
            
        wm.trigger "ready", wm
    
    wm.fetch 
        success: wmFetchedCB

#-------------------------------------------------------------------------------
setUpDefaultWorkspace = ->
    name = "default"
    workspace = new Workspace
        name: name
        shells: []
        
    workspace.sync = Storage.sync "shelley.ws.#{name}"
    workspace.save()
    
    wm.lastWorkspaceName = name
    wm.save()
    
    wm.workspaceNames = [name]
    wm.workspaces = new Workspace
        name:   name
        shells: []
    wm.workspaces


#-------------------------------------------------------------------------------
main()

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
