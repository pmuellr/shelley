require.define("/AboutShell.coffee", Function(
    [ 'require', 'module', 'exports', '__dirname', '__filename' ],
    "(function() {\n  var AboutShell, shelley;\n  var __hasProp = Object.prototype.hasOwnProperty, __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };\n\n  shelley = require('shelley');\n\n  module.exports = AboutShell = (function() {\n\n    __extends(AboutShell, shelley.ShellProvider);\n\n    function AboutShell() {\n      AboutShell.__super__.constructor.apply(this, arguments);\n    }\n\n    AboutShell.prototype.initialize = function(options) {\n      return AboutShell.__super__.initialize.apply(this, arguments);\n    };\n\n    return AboutShell;\n\n  })();\n\n}).call(this);\n\n//@ sourceURL=/AboutShell.coffee"
));

require.alias("/shelley", "/node_modules/shelley");

require.define("/index.coffee", Function(
    [ 'require', 'module', 'exports', '__dirname', '__filename' ],
    "(function() {\n  var AboutShell, main, onClick, shelley;\n\n  shelley = require('shelley');\n\n  AboutShell = require('./AboutShell');\n\n  main = function() {\n    $('#button-open-about-shell').click(onClick);\n    shelley.setWorkspace('shelley-samples-about');\n    return shelley.restoreWorkspace();\n  };\n\n  onClick = function() {\n    shelley.createShell(AboutShell, {\n      persistent: true,\n      persistentSize: true,\n      persistentPosition: false\n    });\n    return alert('you clicked me!');\n  };\n\n  $(document).ready(main);\n\n}).call(this);\n\n//@ sourceURL=/index.coffee"
));
require("/index.coffee");
