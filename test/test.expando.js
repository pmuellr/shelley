// Generated by CoffeeScript 1.3.3
(function() {
  var Backbone, LocalStorage, Point, shelley,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  shelley = require("shelley");

  Backbone = require("backbone");

  LocalStorage = require("shelley/persist/LocalStorage");

  Point = (function(_super) {

    __extends(Point, _super);

    function Point() {
      return Point.__super__.constructor.apply(this, arguments);
    }

    shelley.declareAttributes(Point, {
      x: {
        type: Number
      },
      y: {
        type: Number
      },
      labels: {
        type: [String]
      }
    });

    Point.prototype.isPoint = function() {
      return true;
    };

    Point.prototype.toString = function() {
      return "" + this.constructor.name + (JSON.stringify(this.attributes));
    };

    return Point;

  })(Backbone.Model);

  describe("expando", function() {
    var p1, p2;
    p1 = null;
    p2 = null;
    beforeEach(function() {
      p1 = new Point({
        x: 1,
        y: 2,
        labels: ["a", "b"]
      });
      return p2 = new Point({
        x: 3,
        y: 4,
        labels: ["c", "d"]
      });
    });
    it("ensure values are set in initialized objects", function() {
      expect(p1.x).toEqual(1);
      expect(p1.y).toEqual(2);
      expect(p1.labels[0]).toEqual("a");
      expect(p1.labels[1]).toEqual("b");
      expect(p2.x).toEqual(3);
      expect(p2.y).toEqual(4);
      expect(p2.labels[0]).toEqual("c");
      return expect(p2.labels[1]).toEqual("d");
    });
    return it("ensure values are verified", function() {
      var setLabelstoNumber, setLabelstoNumberArray, setXtoString;
      setXtoString = function() {
        return p1.x = "abc";
      };
      setLabelstoNumber = function() {
        return p1.labels = 5;
      };
      setLabelstoNumberArray = function() {
        return p1.labels = [6, 7, 8];
      };
      expect(setXtoString).toThrow();
      expect(setLabelstoNumber).toThrow();
      return expect(setLabelstoNumberArray).toThrow();
    });
  });

}).call(this);
