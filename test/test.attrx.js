// Generated by CoffeeScript 1.3.3
(function() {
  var A, B, B2, Backbone, C, D, attrx,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  Backbone = require("backbone");

  attrx = require("shelley/attrx");

  D = (function(_super) {

    __extends(D, _super);

    function D() {
      return D.__super__.constructor.apply(this, arguments);
    }

    attrx.declareAttributes(D, {
      s: {
        type: String
      }
    });

    return D;

  })(Backbone.Model);

  B = (function(_super) {

    __extends(B, _super);

    function B() {
      return B.__super__.constructor.apply(this, arguments);
    }

    attrx.declareAttributes(B, {
      b: {
        type: Boolean
      },
      md: {
        type: D
      }
    });

    return B;

  })(Backbone.Model);

  B2 = (function(_super) {

    __extends(B2, _super);

    function B2() {
      return B2.__super__.constructor.apply(this, arguments);
    }

    attrx.declareAttributes(B2, {
      n: {
        type: Number
      }
    });

    return B2;

  })(B);

  C = (function(_super) {

    __extends(C, _super);

    function C() {
      return C.__super__.constructor.apply(this, arguments);
    }

    attrx.declareAttributes(C, {
      mb: {
        type: B
      },
      mb2: {
        type: B2
      }
    });

    return C;

  })(Backbone.Model);

  A = (function(_super) {

    __extends(A, _super);

    function A() {
      return A.__super__.constructor.apply(this, arguments);
    }

    attrx.declareAttributes(A, {
      b: {
        type: Boolean
      },
      n: {
        type: Number
      },
      s: {
        type: String
      },
      d: {
        type: Date
      },
      o: {
        type: Object
      },
      ab: {
        type: [Boolean]
      },
      ao: {
        type: [Object]
      },
      aab: {
        type: [[Boolean]]
      },
      aao: {
        type: [[Object]]
      },
      mb: {
        type: B
      },
      mc: {
        type: C
      },
      amb: {
        type: [B]
      },
      amc: {
        type: [C]
      },
      aamb: {
        type: [[B]]
      },
      aamc: {
        type: [[C]]
      }
    });

    return A;

  })(Backbone.Model);

  describe("attrx", function() {
    var date, ma, mb, mb2, mc, md, rando1, rando2, _ref;
    _ref = [], ma = _ref[0], mb = _ref[1], mb2 = _ref[2], mc = _ref[3], md = _ref[4], date = _ref[5], rando1 = _ref[6], rando2 = _ref[7];
    beforeEach(function() {
      ma = new A;
      mb = new B;
      mb2 = new B2;
      mc = new C;
      md = new D;
      date = new Date;
      rando1 = {
        x: 1,
        y: false
      };
      return rando2 = {
        x: 2,
        y: "s"
      };
    });
    it("handles parsing base types", function() {
      var attrs, d, ma2;
      d = new Date;
      ma.b = true;
      ma.n = 5;
      ma.s = "x";
      ma.d = d;
      ma.o = rando1;
      attrs = ma.toJSON();
      ma2 = new A(attrs, {
        parse: true
      });
      expect(ma2.b).toEqual(true);
      expect(ma2.n).toEqual(5);
      expect(ma2.s).toEqual("x");
      expect(ma2.d.toISOString()).toEqual(d.toISOString());
      return expect(ma2.o).toEqual(rando1);
    });
    it("handles parsing array types", function() {
      var ab, ao, attrs, ma2;
      ab = [true, false, true];
      ao = [rando1, rando2, rando1];
      ma.ab = ab;
      ma.ao = ao;
      ma.aab = [ab];
      ma.aao = [ao];
      attrs = ma.toJSON();
      ma2 = new A(attrs, {
        parse: true
      });
      expect(ma2.ab).toEqual(ab);
      expect(ma2.ao).toEqual(ao);
      expect(ma2.aab).toEqual([ab]);
      return expect(ma2.aao).toEqual([ao]);
    });
    it("handles parsing scalar model types", function() {
      var attrs, ma2;
      ma.mb = mb;
      ma.mc = mc;
      mb.md = md;
      mb2.n = 5;
      mb2.b = true;
      mc.mb = mb;
      mc.mb2 = mb2;
      md.s = "x";
      attrs = ma.toJSON();
      ma2 = new A(attrs, {
        parse: true
      });
      expect(ma2.mb.toJSON()).toEqual(mb.toJSON());
      expect(ma2.mc.toJSON()).toEqual(mc.toJSON());
      ma.mb = mb2;
      attrs = ma.toJSON();
      ma2 = new A(attrs, {
        parse: true
      });
      return expect(ma2.mb.toJSON()).toEqual(mb2.toJSON());
    });
    it("handles parsing arrayed model types", function() {
      var attrs, ma2;
      ma.mb = mb;
      ma.mc = mc;
      attrs = ma.toJSON();
      return ma2 = new A(attrs, {
        parse: true
      });
    });
    it("handles scalar model types", function() {
      ma.mb = mb;
      ma.mc = mc;
      mb.b = true;
      mb.mc = mc;
      mc.c_n = 5;
      mc.b = true;
      expect(ma.mb).toEqual(mb);
      expect(ma.mc).toEqual(mc);
      expect(mb.b).toEqual(true);
      expect(mb.mc).toEqual(mc);
      expect(mc.c_n).toEqual(5);
      expect(mc.b).toEqual(true);
      ma.mb = mb2;
      expect(ma.mb).toEqual(mb2);
      ma.mb = null;
      ma.mc = null;
      mb.mc = null;
      expect(ma.mb).toEqual(null);
      expect(ma.mc).toEqual(null);
      return expect(mb.mc).toEqual(null);
    });
    it("handles invalid scalar model types", function() {
      var set_mb2_to_mb, set_mb_to_ma, set_mb_to_string;
      set_mb_to_string = function() {
        return ma.mb = "abc";
      };
      set_mb_to_ma = function() {
        return ma.mb = ma;
      };
      set_mb2_to_mb = function() {
        return mc.mb2 = mb;
      };
      expect(set_mb_to_string).toThrow();
      expect(set_mb_to_ma).toThrow();
      return expect(set_mb2_to_mb).toThrow();
    });
    it("handles base types", function() {
      ma.b = true;
      ma.n = 5;
      ma.s = "x";
      ma.o = date;
      expect(ma.b).toEqual(true);
      expect(ma.n).toEqual(5);
      expect(ma.s).toEqual("x");
      expect(ma.o).toEqual(date);
      ma.b = null;
      ma.n = void 0;
      ma.s = null;
      ma.o = void 0;
      expect(ma.b).toEqual(null);
      expect(ma.n).toEqual(void 0);
      expect(ma.s).toEqual(null);
      return expect(ma.o).toEqual(void 0);
    });
    it("handles invalid base types", function() {
      var set_b_string, set_n_string, set_s_number;
      set_b_string = function() {
        return ma.b = "abc";
      };
      set_n_string = function() {
        return ma.n = "abc";
      };
      set_s_number = function() {
        return ma.s = 5;
      };
      expect(set_b_string).toThrow();
      expect(set_n_string).toThrow();
      return expect(set_s_number).toThrow();
    });
    it("handles basic array types", function() {
      var aab, aao, ab, ao;
      ab = [true, false];
      ao = [date, rando1];
      aab = [[false, true, false]];
      aao = [[[date, rando1, date]]];
      ma.ab = ab;
      ma.ao = ao;
      ma.aab = aab;
      ma.aao = aao;
      expect(ma.ab).toEqual(ab);
      expect(ma.ao).toEqual(ao);
      expect(ma.aab).toEqual(aab);
      expect(ma.aao).toEqual(aao);
      ma.ab = null;
      ma.ao = void 0;
      ma.aab = null;
      ma.aao = void 0;
      expect(ma.ab).toEqual(null);
      expect(ma.ao).toEqual(void 0);
      expect(ma.aab).toEqual(null);
      expect(ma.aao).toEqual(void 0);
      ma.ab = [];
      ma.ao = [];
      ma.aab = [[]];
      ma.aao = [[]];
      expect(ma.ab).toEqual([]);
      expect(ma.ao).toEqual([]);
      expect(ma.aab).toEqual([[]]);
      return expect(ma.aao).toEqual([[]]);
    });
    return it("handles invalid basic array types", function() {
      var aab, ab, ab1, set_aab, set_aab_to_ab1, set_ab;
      ab = [3, 4];
      aab = [[7, 8, 9]];
      ab1 = [true, false];
      set_ab = function() {
        return ma.ab = ab;
      };
      set_aab = function() {
        return ma.aab = aab;
      };
      set_aab_to_ab1 = function() {
        return ma.aab = ab1;
      };
      expect(set_ab).toThrow();
      expect(set_aab).toThrow();
      return expect(set_aab_to_ab1).toThrow();
    });
  });

}).call(this);
