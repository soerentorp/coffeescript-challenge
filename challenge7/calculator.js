(function() {
  var Calculator, root;

  root = typeof exports !== "undefined" && exports !== null ? exports : window;

  Calculator = (function() {

    function Calculator(input, base) {
      this.input = input;
      this.base = base;
    }

    Calculator.prototype.result = function() {
      var input, number;
      input = this.input.replace(/\s/g, "");
      if (Calculator.legal_characters(input)) {
        if (/^[\+\-\*\/]/g.test(input)) {
          number = eval(this.base + input);
        } else {
          number = eval(input);
        }
      } else {
        number = 0;
      }
      if (isFinite(number)) {
        return number;
      } else {
        return 0;
      }
    };

    Calculator.legal_characters = function(input) {
      if (/[^\d^\+^\-^\*^\/^\(^\)]/g.test(input)) {
        return false;
      } else {
        return true;
      }
    };

    Calculator.split = function(number, parts) {
      var amount;
      number = parseFloat(number);
      parts = parseInt(parts);
      amount = number / parts;
      if (isFinite(amount)) {
        return amount;
      } else {
        return 0;
      }
    };

    return Calculator;

  })();

  root.Calculator = Calculator;

}).call(this);
