// Licensed under the Tumbolia Public License. See footer for details.

var Shell = require("./Shell")

var WorkspaceManager = exports

var AllShells = []

//------------------------------------------------------------------------------
WorkspaceManager.createShell = function createShell(name, shellClass, options) {
    var shell = new Shell(name, shellClass, options)
    if (!shell) return

    AllShells.push(shell)

    return shell
}

//------------------------------------------------------------------------------
WorkspaceManager.destroyShell = function destroyShell(shell) {
    var i = AllShells.indexOf(shell)
    if (i == -1) return

    AllShells.splice(i,1)

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
