# Licensed under the Tumbolia Public License. See footer for details.

#-------------------------------------------------------------------------------
module.exports = class Shell

    _        = require 'underscore'
    Backbone = require 'backbone'
    
    shelley  = require 'shelley'

    _.extend(Shell, Backbone.Events)

    #---------------------------------------------------------------------------
    constructor: (options) ->
        options = _.defaults options, 
            title:     "<???>"
            x:         null
            y:         null
            width:     400
            height:    300
            
        element = options.element
        title   = options.title

        @$element = $(element || "<div>")
        @element = @$element[0]
        
        @$element.dialog
            autoOpen:      false
            closeOnEscape: false
            title:         title

        @_$shell = @$element.dialog("widget")
        
        x = options.x
        y = options.y
        w = options.width
        h = options.height
        
        if !x or !y
            [x, y] = generateRandomPosition(w, h)

        @$element.dialog "option",
            width: w
            height: h
            position: [x,y]
            
    #---------------------------------------------------------------------------
    title: (value) ->
        if value
            @$element.dialog "option", "title", value
            
        @$element.dialog "option", "title"

    #---------------------------------------------------------------------------
    open: ->
        @_$shell.show()

    #---------------------------------------------------------------------------
    close: ->
        @_$shell.hide()

    #---------------------------------------------------------------------------
    destroy: ->
        @close()
        @$element.dialog("destroy")
        @$element.remove()
        
        @$element = null
        @_$shell  = null
        
    #---------------------------------------------------------------------------
    generateRandomPosition = (width, height) ->
        body = $(document.body)
        pWidth  = body.width()
        pHeight = body.height()
        
        x = Math.random() * (pWidth  - width  - 40)
        y = Math.random() * (pHeight - height - 40)
        
        x = Math.max(0, x)
        y = Math.max(0, y)
        
        [x, y]

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
