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

module.exports = class StorageSync

    # original sync function
    OldSync = Backbone.sync

    #-------------------------------------------------------------------------------
    # replacement for Backbone.sync
    #-------------------------------------------------------------------------------
    @sync: (method, model, options) ->
    
        # get the collection and storage
        collection = model?.collection || model
        storage    = collection?.storage
        
        # not an model/collection we handle? delegate to the old sync
        if !storage
            if OldSync != StorageSync.sync
                return OldSync.apply(this, arguments)

        if (method == "read") && (model == collection)
            method = "readAll"

        # call the storage method                
        [error, response] = storage[method].call(storage, collection, model)

        # handle error
        if error
            console.log "sync: error"
            if options.error
                setTimeout(
                    -> options.error error, 
                    0
                )
            else
                console.log "error sync #{method}: #{error}"
                
        # handle success
        else
            if options.success
                setTimeout(
                    -> options.success(response), 
                    0
                )
            
    
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
