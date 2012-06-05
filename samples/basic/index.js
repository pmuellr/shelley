// Generated by CoffeeScript 1.3.3
(function() {
  var HelloWorldShell, main, openShell, shelley,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  shelley = require('shelley');

  main = function() {
    $('#button-open-shell').click(openShell);
    shelley.registerShellModel("hello.world", HelloWorldShell);
    return shelley.ws.open();
  };

  HelloWorldShell = (function(_super) {

    __extends(HelloWorldShell, _super);

    function HelloWorldShell() {
      return HelloWorldShell.__super__.constructor.apply(this, arguments);
    }

    HelloWorldShell.prototype.initialize = function(attrs) {};

    HelloWorldShell.prototype.createContent = function() {
      var content;
      content = $("<div>");
      content.html("<p>Hello, World! <p>opened at: " + (this.get('date')));
      return content[0];
    };

    return HelloWorldShell;

  })(shelley.models.Shell);

  openShell = function() {
    return shelley.createShell("hello.world", {
      date: Date()
    });
  };

  $(document).ready(main);

}).call(this);
