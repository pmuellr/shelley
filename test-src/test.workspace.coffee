# Licensed under the Tumbolia Public License. See footer for details.

shelley = require "shelley"

#-------------------------------------------------------------------------------
describe "workspaces", ->

    #---------------------------------------------------------------------------
    beforeEach ->
        
    #---------------------------------------------------------------------------
    afterEach ->

    #---------------------------------------------------------------------------
    it "should not have any workspaces when starting", () ->
        wss = shelley.getWorkspaces()
        expect(wss.length).toEqual(0)

    #---------------------------------------------------------------------------
    it "should create a new workspaces", () ->
        ws = shelley.createWorkspace("test-2")
        
        expect(ws.get("name")).toEqual("test-2")


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
