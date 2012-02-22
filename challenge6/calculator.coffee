root = exports ? window

class Calculator
  constructor: (@input, @base) ->

  result: ->
    input = @input.replace(/\s/g, "") # remove white spaces
    try
      if Calculator.legal_characters(input)
        if /^[\+\-\*\/]/g.test(input) # check for + - * / characters in the first position
          number = eval(@base + input)
        else
          number = eval(input)
      else
        number = 0
    catch error
      console.log "Error: " + error.message
      number = 0
      
    if isFinite(number) then number else 0 # check if calculation makes sense

  @legal_characters: (input) ->
    if /[^\d^\+^\-^\*^\/^\(^\)]/g.test(input) # if there are other characters than the legal ones (digits, +, -, *, /, left or right brackets)...
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
