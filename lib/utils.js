// Licensed under the Tumbolia Public License. See footer for details.

var utils = exports

var _        = require("underscore")
var backbone = require("backbone")

//------------------------------------------------------------------------------
exports.newClass = function newModelClass(superClass, instMethods, statMethods) {
    superClass = superClass || Backbone.Model

    instMethods = arr2obj(instMethods)
    statMethods = arr2obj(statMethods)

    return superClass.extend(instMethods, statMethods)
}

//------------------------------------------------------------------------------
function arr2obj(arr) {
    var result = {}

    for (var i=0; i<arr.length; i++) {
        result[arr[i].name] = arr[i]
    }

    return result
}

//------------------------------------------------------------------------------
// Copyright (c) 2012 Patrick Mueller
//
// Tumbolia Public License
//
// Copying and distribution of this file, with or without modification, are
// permitted in any medium without royalty provided the copyright notice and
// this notice are preserved.
//
// TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
//
//   0. opan saurce LOL
//------------------------------------------------------------------------------
