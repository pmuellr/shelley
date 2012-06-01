# Licensed under the Tumbolia Public License. See footer for details.

require "shelley"

Backbone     = require "backbone"
LocalStorage = require "shelley/persist/LocalStorage"

#-------------------------------------------------------------------------------
class Point extends Backbone.Model
    
    #---------------------------------------------------------------------------
    isPoint: -> true

    #---------------------------------------------------------------------------
    toString: -> "#{@constructor.name}#{JSON.stringify(@attributes)}"

#-------------------------------------------------------------------------------
unexpectedError = (e) -> 
    throw new Error "should not have errored with #{e}"

#-------------------------------------------------------------------------------
describe "persist", ->

    #---------------------------------------------------------------------------
    beforeEach ->
        
    #---------------------------------------------------------------------------
    afterEach ->

    #---------------------------------------------------------------------------
    it "should handle new collections", () ->
        coll = new Backbone.Collection null, model: Point
            
        coll.storage = new LocalStorage name:"test-1"
            
        point = 
            x: 1
            y: 2
        
        createdModel = null

        #-----------------------------------------------------------------------        
        createdModelCB = (model) -> 
            createdModel = model
        
        #-----------------------------------------------------------------------        
        runs ->
            coll.create point, 
                error:   unexpectedError
                success: createdModelCB
                 
        #-----------------------------------------------------------------------        
        waiter = ->
            return createdModel
            
        #-----------------------------------------------------------------------        
        waitsFor waiter, "The model should have been created", 1000
        
        #-----------------------------------------------------------------------        
        runs ->
            expect(createdModel.get("x")).toEqual(point.x)
            expect(createdModel.get("y")).toEqual(point.y)
            
    #---------------------------------------------------------------------------
    it "should handle fetching a saved collection", () ->
        coll = new Backbone.Collection null, model: Point
            
        coll.storage = new LocalStorage name:"test-2"
            
        point = 
            x: 1
            y: 2
        
        restoredColl = null

        #-----------------------------------------------------------------------        
        createdModelCB = (model) ->
            expect(model.get("x")).toEqual(point.x)
            
            coll.fetch
                error:   unexpectedError
                success: fetchedCollCB
            
        #-----------------------------------------------------------------------        
        fetchedCollCB = (coll) ->
            restoredColl = coll

        #-----------------------------------------------------------------------        
        runs ->
            coll.create point, 
                error:   unexpectedError
                success: createdModelCB
                 
        #-----------------------------------------------------------------------        
        waiter = ->
            return restoredColl
            
        #-----------------------------------------------------------------------        
        waitsFor waiter, "The collection should have been fetched", 1000
        
        #-----------------------------------------------------------------------        
        runs ->
            expect(restoredColl.at(0).get("x")).toEqual(point.x)
            expect(restoredColl.at(0).get("y")).toEqual(point.y)
            
    #---------------------------------------------------------------------------
    it "should handle updating an item", () ->
        coll = new Backbone.Collection null, model: Point
            
        coll.storage = new LocalStorage name:"test-3"
            
        point = 
            x: 1
            y: 2
        
        restoredColl = null

        #-----------------------------------------------------------------------        
        createdModelCB = (model) ->
            expect(model.get("x")).toEqual(point.x)
            
            model.set("x", 3)
            
            model.save null,
                error:   unexpectedError
                success: updatedModelCB
            
        #-----------------------------------------------------------------------        
        updatedModelCB = (model) ->
            expect(model.get("x")).toEqual(3)
            
            coll.fetch
                error:   unexpectedError
                success: fetchedCollCB

        #-----------------------------------------------------------------------        
        fetchedCollCB = (coll) ->
            restoredColl = coll

        #-----------------------------------------------------------------------        
        runs ->
            coll.create point, 
                error:   unexpectedError
                success: createdModelCB
                 
        #-----------------------------------------------------------------------        
        waiter = ->
            return restoredColl
            
        #-----------------------------------------------------------------------        
        waitsFor waiter, "The collection should have been updated", 1000
        
        #-----------------------------------------------------------------------        
        runs ->
            expect(restoredColl.length).toEqual(1)
            expect(restoredColl.at(0).get("x")).toEqual(3)
            expect(restoredColl.at(0).get("y")).toEqual(point.y)
            
    #---------------------------------------------------------------------------
    it "should handle deleting an item", () ->
        coll = new Backbone.Collection null, model: Point
            
        coll.storage = new LocalStorage name:"test-4"
            
        point = 
            x: 1
            y: 2
        
        restoredColl = null

        #-----------------------------------------------------------------------        
        createdModelCB = (model) ->
            model.destroy
                error:   unexpectedError
                success: deletedModelCB
            
        #-----------------------------------------------------------------------        
        deletedModelCB = (model) ->
            expect(model.get("x")).toEqual(point.x)
            expect(model.get("y")).toEqual(point.y)
            expect(coll.length).toEqual(0)
            
            coll.fetch
                error:   unexpectedError
                success: fetchedCollCB

        #-----------------------------------------------------------------------        
        fetchedCollCB = (coll) ->
            restoredColl = coll

        #-----------------------------------------------------------------------        
        runs ->
            coll.create point, 
                error:   unexpectedError
                success: createdModelCB
                 
        #-----------------------------------------------------------------------        
        waiter = ->
            return restoredColl
            
        #-----------------------------------------------------------------------        
        waitsFor waiter, "The model should have been deleted", 1000
        
        #-----------------------------------------------------------------------        
        runs ->
            expect(restoredColl.length).toEqual(0)
            
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
