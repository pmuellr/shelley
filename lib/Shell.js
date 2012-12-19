// Licensed under the Tumbolia Public License. See footer for details.

var _ = require("undescore")


function asObj(arr) {
    _.reduce(arr, function(element, result) {
        result[element.name] = element
    }, {})
}

var Shell = Backbone.Model.extend(
    asObj([
        destroy
    ]),
    asObj([

    ])
)


//------------------------------------------------------------------------------
function destroy() {
}

//------------------------------------------------------------------------------
WorkspaceManager.destroyShell = function destroyShell(shell) {
    var index = AllShells.indexOf(shell)
    if (-1 == index) return

    AllShells.splice(index,1)

    shell.destroy()

    return shell
}

//------------------------------------------------------------------------------
WorkspaceManager.listShells = function listShells() {
    return AllShells.slice()
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
