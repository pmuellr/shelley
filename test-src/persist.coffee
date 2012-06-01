# Licensed under the Tumbolia Public License. See footer for details.

Backbone = require "backbone"
should   = require "should"

LocalStorage = require "../lib-src/persist/LocalStorage"
StorageSync  = require "../lib-src/persist/StorageSync"

Backbone.sync = StorageSync.sync

#-------------------------------------------------------------------------------
delayed = (millis, func) ->
    setTimeout(func, millis)
    
if !window
    window = {}
    global.window = window
    
if !window.localStorage
    window.localStorage =
        _items:  {}
        getItem: (name)        -> window.localStorage._items[name]
        setItem: (name, value) -> window.localStorage._items[name] = value
        clear:   ()            -> window.localStorage._items = {}

#-------------------------------------------------------------------------------
class Point extends Backbone.Model
    
    #---------------------------------------------------------------------------
    isPoint: -> true

#-------------------------------------------------------------------------------
describe "persist", ->

    #---------------------------------------------------------------------------
    beforeEach ->
        window.localStorage.clear()
        
    #---------------------------------------------------------------------------
    after ->
        window.localStorage.clear()

    #---------------------------------------------------------------------------
    it "should handle new collections", (done) ->
        coll = new Backbone.Collection 
            model: Point
            
        coll.storage = new LocalStorage name:"test-1"
            
        point = 
            x: 1
            y: 2
        
        point = coll.create point, 
        
            success: (model)->
                model.get("x").should.equal(1)
                model.get("y").should.equal(2)
                done()
                
            error: (e) ->
                should.fail "should not have errored with #{e}"

    #---------------------------------------------------------------------------
    it "should support restoring", (done) ->
        coll = new Backbone.Collection 
            model: Point
            
        coll.storage = new LocalStorage name:"test-2"
            
        point = 
            x: 3
            y: 4
        
        point = coll.create point, 
        
            success: (model)->
                coll2 = new Backbone.Collection 
                    model: Point
                    
                coll2.storage = new LocalStorage name:"test-2"
                coll2.fetch
                    success: (coll3) ->
                        console.log JSON.stringify(coll3)
                        should.exist(coll3)
                        coll3.should.equal(coll2)
                        coll3.length.should.equal(coll.length)
                        
                        item = coll3.at(0)
                        should.exist(item)
                        
                        item.get("x").should.equal(4)
                        item.get("y").should.equal(3)
                    error: (e) ->
                        should.fail "should not have errored with #{e}"
                
                
                
                done()
                
            error: (e) ->
                should.fail "should not have errored with #{e}"

        
        
        
###        
    it "test 5", (done) ->
        delayed 500, ->
            0.should.equal(0) 
            done()
###            

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
