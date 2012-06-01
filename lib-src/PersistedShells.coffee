# Licensed under the Tumbolia Public License. See footer for details.

#-------------------------------------------------------------------------------
module.exports = class PersistedShells extends require("backbone").Collection

    PersistedShell    = require("./PersistedShell")
    LocalStorageStore = require("./LocalStorageStore")

    #-------------------------------------------------------------------------------
    initialize: (models, options) ->
        ws = options.ws
        if !ws
            throw new Error "workspace not specified in options"
            
        url = "shelley-#{ws.name}-PersistedShells"
        
        @model = PersistedShell
        @store = new LocalStorageStore(url)
    
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
