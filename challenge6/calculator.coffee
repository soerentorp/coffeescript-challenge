root = exports ? window

class Calculator
  constructor: (@input) ->

  result: ->
    if Calculator.legal_characters(@input) # 
      eval @input
    else
      0

  @legal_characters: (input) ->
    if /[^\d^\+^\*^\/]/g.test(input) # if there are other characters than the legal ones...
      false
    else
      true

  @split: (number, parts) -> 
    number = parseFloat(number)
    parts = parseInt(parts)
    amount = number / parts

    if isFinite(amount)
      amount
    else
      0

root.Calculator = Calculator
