# Licensed under the Tumbolia Public License. See footer for details.

_        = require 'underscore'
Backbone = require 'backbone'

shelley  = require 'shelley'

#-------------------------------------------------------------------------------

module.exports = class Shell

    #---------------------------------------------------------------------------
    constructor: (options, controllerClass) ->
        options = _.defaults options, 
            title:     "<???>"
            closeable: true
            modal:     false
            x:         null
            y:         null
            width:     400
            height:    300
            
        @_modal = options.modal
        
        element = options.element
        
        title = options.title

        @$element = $(element || "<div>")
        @element = @$element[0]
        
        @$element.dialog
            autoOpen:      @_modal
            closeOnEscape: false
            title:         title
            modal:         @_modal
        
        @_$shell = @$element.dialog("widget")
        
        return if @_modal
        
        if !options.closeable
            $(".ui-dialog-titlebar-close", @_$shell).hide()
            
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

#-------------------------------------------------------------------------------
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
