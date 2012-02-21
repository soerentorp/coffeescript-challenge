root = exports ? window

class Calculator
  constructor: (@input, @base) ->

  result: ->
    if Calculator.legal_characters(@input)
      if /^[\+\-\*\/]/g.test(@input)
        number = eval(@base + @input)
      else
        number = eval(@input)
    else
      number = 0
      
    if isFinite(number) then number else 0

  @legal_characters: (input) ->
    if /[^\d^\+^\-^\*^\/]/g.test(input) # if there are other characters than the legal ones...
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
