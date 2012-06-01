# Licensed under the Tumbolia Public License. See footer for details.

#-------------------------------------------------------------------------------
# base Storage class for StorageSync
#-------------------------------------------------------------------------------

module.exports = class Storage

    #-------------------------------------------------------------------------------
    constructor: ->
        @initialize.apply(@,arguments)
        
    #-------------------------------------------------------------------------------
    initialize: ->
        console.log "in Storage.initialize()"
    
    #-------------------------------------------------------------------------------
    create: (collection, model) ->
        throw new Error "subclass responsibility"
    
    #-------------------------------------------------------------------------------
    read: (collection, model) ->
        throw new Error "subclass responsibility"
    
    #-------------------------------------------------------------------------------
    readAll: (collection, model) ->
        throw new Error "subclass responsibility"
    
    #-------------------------------------------------------------------------------
    update: (collection, model) ->
        throw new Error "subclass responsibility"
    
    #-------------------------------------------------------------------------------
    delete: (collection, model) ->
        throw new Error "subclass responsibility"            
    
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
