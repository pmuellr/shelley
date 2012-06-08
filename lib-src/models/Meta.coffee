# Licensed under the Tumbolia Public License. See footer for details.

Backbone = require "backbone"
_        = require "underscore"

attrx = require "../attrx"

#-------------------------------------------------------------------------------
meta = module.exports = new class Meta extends Backbone.Model

    #---------------------------------------------------------------------------
    toString: -> "#{@constructor.name}#{JSON.stringify(@attributes)}"
    
    #---------------------------------------------------------------------------
    attrx.declareAttributes @, 
        workspaces:       type: [String]
        currentWorkspace: type: String

#-------------------------------------------------------------------------------
collection = new Backbone.Collection null, model: Meta
collection.storage = new LocalStorage name: "shelley.meta"

collection.fetch
    error:   unexpectedError
    success: (coll) => 
        if coll.length
            saved = coll.at 0
            meta.workspaces       = saved.workspaces
            meta.currentWorkspace = saved.currentWorkspace
            meta.trigger "ready"
            return
            
        workspace = new Workspace
            name: "default"
            shells: []
        
        meta.workspaces       = [workspace]
        meta.currentWorkspace = workspace.name
        meta.trigger "ready"
        
        coll.add meta
        meta.save()

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
