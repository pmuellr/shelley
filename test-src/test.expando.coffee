# Licensed under the Tumbolia Public License. See footer for details.

shelley = require "shelley"

Backbone     = require "backbone"
LocalStorage = require "shelley/persist/LocalStorage"

#-------------------------------------------------------------------------------
class Point extends Backbone.Model

    shelley.declareAttributes Point, 
        x: 
            type: Number
        y:
            type: Number
        labels:
            type: [String]
    
    #---------------------------------------------------------------------------
    isPoint: -> true

    #---------------------------------------------------------------------------
    toString: -> "#{@constructor.name}#{JSON.stringify(@attributes)}"

#-------------------------------------------------------------------------------
describe "expando", ->
    p1 = null
    p2 = null

    #---------------------------------------------------------------------------
    beforeEach ->
        p1 = new Point x: 1, y: 2, labels: ["a", "b"]
        p2 = new Point x: 3, y: 4, labels: ["c", "d"]
        
    #---------------------------------------------------------------------------
    it "ensure values are set in initialized objects", () ->
    
        expect(p1.x).toEqual(1)
        expect(p1.y).toEqual(2)
        expect(p1.labels[0]).toEqual("a")
        expect(p1.labels[1]).toEqual("b")
        
        expect(p2.x).toEqual(3)
        expect(p2.y).toEqual(4)
        expect(p2.labels[0]).toEqual("c")
        expect(p2.labels[1]).toEqual("d")

    #---------------------------------------------------------------------------
    it "ensure values are verified", () ->
        setXtoString = -> 
            p1.x = "abc"
            
        setLabelstoNumber = -> 
            p1.labels = 5
    
        setLabelstoNumberArray = -> 
            p1.labels = [6,7,8]
    
        expect(setXtoString).toThrow()
        expect(setLabelstoNumber).toThrow()
        expect(setLabelstoNumberArray).toThrow()
            
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
