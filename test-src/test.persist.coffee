# Licensed under the Tumbolia Public License. See footer for details.

Backbone = require "backbone"

Storage  = require "shelley/persist/ModelLocalStorageSync"
attrx    = require "shelley/attrx"

#-------------------------------------------------------------------------------
class Point extends Backbone.Model
    
    #---------------------------------------------------------------------------
    attrx.declareAttributes @, 
        x:  type: Number
        y:  type: Number
        
    #---------------------------------------------------------------------------
    isPoint: -> true

#-------------------------------------------------------------------------------
unexpectedError = (model, e) -> 
    throw new Error "should not have errored with #{e}"

#-------------------------------------------------------------------------------
describe "persist", ->

    point12 = null
    
    #---------------------------------------------------------------------------
    beforeEach ->
        point12 = new Point
            x: 1
            y: 2
        
    #---------------------------------------------------------------------------
    afterEach ->

    #---------------------------------------------------------------------------
    it "should handle new models", () ->
            
        point12.sync = Storage.sync "test-1"
        
        createdModel = null

        #-----------------------------------------------------------------------        
        createdModelCB = (model, attrs) -> 
            createdModel = model
        
        #-----------------------------------------------------------------------        
        runs ->
            point12.save null,
                error:   unexpectedError
                success: createdModelCB
                 
        #-----------------------------------------------------------------------        
        waiter = ->
            return createdModel
            
        #-----------------------------------------------------------------------        
        waitsFor waiter, "The model should have been created", 1000
        
        #-----------------------------------------------------------------------        
        runs ->
            expect(createdModel.x).toEqual(point12.x)
            expect(createdModel.y).toEqual(point12.y)
            expect(createdModel.isPoint()).toEqual(true)
            
    #---------------------------------------------------------------------------
    it "should handle fetching a saved model", () ->
        point = new Point
        point.sync = Storage.sync "test-1"
            
        fetchedModel = null

        #-----------------------------------------------------------------------        
        fetchedModelCB = (model, attrs) -> 
            fetchedModel = model
        
        #-----------------------------------------------------------------------        
        runs ->
            point.fetch
                error:   unexpectedError
                success: fetchedModelCB
                 
        #-----------------------------------------------------------------------        
        waiter = ->
            return fetchedModel
            
        #-----------------------------------------------------------------------        
        waitsFor waiter, "The model should have been fetched", 1000
        
        #-----------------------------------------------------------------------        
        runs ->
            expect(fetchedModel.x).toEqual(point12.x)
            expect(fetchedModel.y).toEqual(point12.y)
            expect(fetchedModel.isPoint()).toEqual(true)
            
    #---------------------------------------------------------------------------
    it "should handle updating a model", () ->
        point = new Point
        point.sync = Storage.sync "test-1"

        updatedModel = null

        #-----------------------------------------------------------------------        
        fetchedModelCB = (model, attrs) -> 
            model.x = 3
            model.save null,
                error:   unexpectedError
                success: updatedModelCB
        
        #-----------------------------------------------------------------------        
        updatedModelCB = (model, attrs) -> 
            updatedModel = model
        
        #-----------------------------------------------------------------------        
        runs ->
            point.fetch
                error:   unexpectedError
                success: fetchedModelCB
                 
        #-----------------------------------------------------------------------        
        waiter = ->
            return updatedModel
            
        #-----------------------------------------------------------------------        
        waitsFor waiter, "The model should have been updated", 1000
        
        #-----------------------------------------------------------------------        
        runs ->
            expect(updatedModel.x).toEqual(3)
            expect(updatedModel.y).toEqual(point12.y)
            expect(updatedModel.isPoint()).toEqual(true)

    #---------------------------------------------------------------------------
    it "should handle deleting a model", () ->
        point = new Point
        point.sync = Storage.sync "test-1"

        deletedModel = null

        #-----------------------------------------------------------------------        
        fetchedModelCB = (model, attrs) -> 
            model.destroy
                error:   unexpectedError
                success: deletedModelCB

        #-----------------------------------------------------------------------        
        deletedModelCB = (model, attrs) -> 
            deletedModel = model
        
        #-----------------------------------------------------------------------        
        runs ->
            point.fetch
                error:   unexpectedError
                success: fetchedModelCB
                 
        #-----------------------------------------------------------------------        
        waiter = ->
            return deletedModel
            
        #-----------------------------------------------------------------------        
        waitsFor waiter, "The model should have been updated", 1000
        
        #-----------------------------------------------------------------------        
        runs ->
            expect(window.localStorage.getItem("test-1")).toBeNull()
            
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
