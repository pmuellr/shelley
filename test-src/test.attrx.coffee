# Licensed under the Tumbolia Public License. See footer for details.

Backbone = require "backbone"

attrx = require "shelley/attrx"

#-------------------------------------------------------------------------------
class D extends Backbone.Model 
    attrx.declareAttributes @, 
        s:  type: String

#-------------------------------------------------------------------------------
class B extends Backbone.Model
    attrx.declareAttributes @, 
        b:  type: Boolean
        md: type: D

#-------------------------------------------------------------------------------
class B2 extends B
    attrx.declareAttributes @, 
        n: type: Number

#-------------------------------------------------------------------------------
class C extends Backbone.Model
    attrx.declareAttributes @, 
        mb:  type: B
        mb2: type: B2

#-------------------------------------------------------------------------------
class A extends Backbone.Model
    attrx.declareAttributes @, 
        b:    type: Boolean
        n:    type: Number
        s:    type: String
        d:    type: Date
        o:    type: Object
        t:    { type: String, transient: true }
        ab:   type: [Boolean]
        ao:   type: [Object]
        aab:  type: [[Boolean]]
        aao:  type: [[Object]]
        mb:   type: B
        mc:   type: C
        amb:  type: [B]
        amc:  type: [C]
        aamb: type: [[B]]
        aamc: type: [[C]]

#-------------------------------------------------------------------------------
describe "attrx", ->
    [ma, mb, mb2, mc, md, date, rando1, rando2] = []

    #---------------------------------------------------------------------------
    beforeEach ->
        ma  = new A
        mb  = new B
        mb2 = new B2
        mc  = new C
        md  = new D
        
        date  = new Date
        
        rando1 = 
            x: 1 
            y: false
            
        rando2 = 
            x: 2 
            y: "s"

    #---------------------------------------------------------------------------
    it "handles transient attributes", () ->
        ma.b = true
        ma.t = "shouldn't be persisted"

        attrs = ma.toJSON()
        ma2 = new A(attrs, parse: true)
        
        expect(attrs.t).toEqual(null)
        expect(ma2.t).toEqual(null)

    #---------------------------------------------------------------------------
    it "handles parsing base types", () ->
        d = new Date
        
        ma.b = true
        ma.n = 5
        ma.s = "x"
        ma.d = d
        ma.o = rando1

        attrs = ma.toJSON()
        ma2 = new A(attrs, parse: true)
        
        expect(ma2.b).toEqual(true)
        expect(ma2.n).toEqual(5)
        expect(ma2.s).toEqual("x")
        expect(ma2.d.toISOString()).toEqual(d.toISOString())
        expect(ma2.o).toEqual(rando1)

    #---------------------------------------------------------------------------
    it "handles parsing array types", () ->
        ab  = [true, false, true]
        ao  = [rando1, rando2, rando1]
    
        ma.ab  = ab
        ma.ao  = ao
        ma.aab = [ab]
        ma.aao = [ao]

        attrs = ma.toJSON()
        ma2 = new A(attrs, parse: true)
        
        expect(ma2.ab).toEqual(ab)
        expect(ma2.ao).toEqual(ao)

# jasmine doesn't like the following, so unrolling        
#        expect(ma2.aab).toEqual([ab])
        expect(ma2.aab.length).toEqual([ab].length)
        for i in [0...ma2.aab.length]
            expect(ma2.aab[i].length).toEqual([ab][i].length)
            for j in [0..ma2.aab[i].length]
                expect(ma2.aab[i][j]).toEqual([ab][i][j])
            
# jasmine doesn't like the following, so unrolling        
#        expect(ma2.aao).toEqual([ao])
        expect(ma2.aao.length).toEqual([ao].length)
        for i in [0...ma2.aao.length]
            expect(ma2.aao[i].length).toEqual([ao][i].length)
            for j in [0..ma2.aao[i].length]
                expect(ma2.aao[i][j]).toEqual([ao][i][j])
        

    #---------------------------------------------------------------------------
    it "handles parsing scalar model types", () ->
        ma.mb = mb
        ma.mc = mc
        
        mb.md = md
        mb2.n = 5
        mb2.b = true

        mc.mb  = mb
        mc.mb2 = mb2
        
        md.s   = "x"

        attrs = ma.toJSON()
        ma2 = new A(attrs, parse: true)
        
        expect(ma2.mb.toJSON()).toEqual(mb.toJSON())
        expect(ma2.mc.toJSON()).toEqual(mc.toJSON())

        ma.mb = mb2

        attrs = ma.toJSON()
        ma2 = new A(attrs, parse: true)
        
        expect(ma2.mb.toJSON()).toEqual(mb2.toJSON())

    #---------------------------------------------------------------------------
    it "handles parsing arrayed model types", () ->

        mb.b = true
        ma.amb = [ mb ]
        attrs = ma.toJSON()
        ma2 = new A(attrs, parse: true)
        
        expect(ma2.amb instanceof Backbone.Collection).toEqual(true)
        expect(ma2.amb.length).toEqual(1)
        expect((ma2.amb.at 0).toJSON()).toEqual(mb.toJSON())

    #---------------------------------------------------------------------------
    it "handles scalar model types", () ->
        ma.mb = mb
        ma.mc = mc
        
        mb.b = true
        mb.mc = mc
        
        mc.c_n = 5
        mc.b   = true

        expect(ma.mb).toEqual(mb)
        expect(ma.mc).toEqual(mc)
        expect(mb.b).toEqual(true)
        expect(mb.mc).toEqual(mc)
        expect(mc.c_n).toEqual(5)
        expect(mc.b).toEqual(true)
        
        ma.mb = mb2
        expect(ma.mb).toEqual(mb2)

        ma.mb = null
        ma.mc = null
        mb.mc = null
        
        expect(ma.mb).toEqual(null)
        expect(ma.mc).toEqual(null)
        expect(mb.mc).toEqual(null)

    #---------------------------------------------------------------------------
    it "handles invalid scalar model types", () ->
        set_mb_to_string = -> 
            ma.mb = "abc"

        set_mb_to_ma = -> 
            ma.mb = ma

        set_mb2_to_mb = -> 
            mc.mb2 = mb
            
        expect(set_mb_to_string).toThrow()
        expect(set_mb_to_ma).toThrow()
        expect(set_mb2_to_mb).toThrow()
        
    #---------------------------------------------------------------------------
    it "handles base types", () ->
        ma.b = true
        ma.n = 5
        ma.s = "x"
        ma.o = date
        
        expect(ma.b).toEqual(true)
        expect(ma.n).toEqual(5)
        expect(ma.s).toEqual("x")
        expect(ma.o).toEqual(date)

        ma.b = null
        ma.n = undefined
        ma.s = null
        ma.o = undefined

        expect(ma.b).toEqual(null)
        expect(ma.n).toEqual(undefined)
        expect(ma.s).toEqual(null)
        expect(ma.o).toEqual(undefined)

    #---------------------------------------------------------------------------
    it "handles invalid base types", () ->
        set_b_string = -> 
            ma.b = "abc"
            
        set_n_string = -> 
            ma.n = "abc"
    
        set_s_number = -> 
            ma.s = 5
    
        expect(set_b_string).toThrow()
        expect(set_n_string).toThrow()
        expect(set_s_number).toThrow()

    #---------------------------------------------------------------------------
    it "handles basic array types", () ->
        ab  =  [true, false]
        ao  =  [date, rando1]
        aab =  [[false, true, false]]
        aao =  [[[date, rando1, date]]]
        
        ma.ab  = ab
        ma.ao  = ao
        ma.aab = aab
        ma.aao = aao

        expect(ma.ab).toEqual(ab)
        expect(ma.ao).toEqual(ao)
        expect(ma.aab).toEqual(aab)
        expect(ma.aao).toEqual(aao)

        ma.ab  = null
        ma.ao  = undefined
        ma.aab = null
        ma.aao = undefined

        expect(ma.ab).toEqual(null)
        expect(ma.ao).toEqual(undefined)
        expect(ma.aab).toEqual(null)
        expect(ma.aao).toEqual(undefined)

        ma.ab  = []
        ma.ao  = []
        ma.aab = [[]]
        ma.aao = [[]]

        expect(ma.ab).toEqual([])
        expect(ma.ao).toEqual([])
        expect(ma.aab).toEqual([[]])
        expect(ma.aao).toEqual([[]])

    #---------------------------------------------------------------------------
    it "handles invalid basic array types", () ->
        ab  = [3,4]
        aab = [[7,8,9]]
        ab1 = [true, false]
        
        set_ab = -> 
            ma.ab  = ab
            
        set_aab = -> 
            ma.aab = aab

        set_aab_to_ab1 = -> 
            ma.aab = ab1

        expect(set_ab).toThrow()
        expect(set_aab).toThrow()
        expect(set_aab_to_ab1).toThrow()
            
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
