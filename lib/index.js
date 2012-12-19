// Licensed under the Tumbolia Public License. See footer for details.

var WorkspaceManager = require("./WorkspaceManager")

exports.createWorkspaceManager = function createWorkspaceManager(el) {
    return new WorkspaceManager(el)
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