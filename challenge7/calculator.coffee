root = exports ? window

class Calculator
  constructor: (@input, @base) ->
    @sanetizedInput = @sanetizeInput @input
    @errors = []
    @resultValue = null
      
  isValid: ->
    @isValidInput() # for now, the input determines whether we are ready to go
      
  result: ->
    return @resultValue if @resultValue? # Don't do it again, if it has already been done
    if @isValidInput()
      result = @calculateValidInput()
      if isFinite(result) then result else 0 # check if calculation makes sense
    else
      throw new Error @errorsInInput() # Throw an exception for the programmer

  sanetizeInput: (input) ->
    input.replace(/\s/g, "") # remove white spaces

  isValidInput: ->
    if /[^\d^\+^\-^\*^\/^\(^\)]/g.test @sanetizedInput 
      # Regular expression used
      # Any of the characters: [...]
      # Which are not: ^
      # Digits: \d
      # Characters: +, -, *, /, ( or ) (math operators)
      # Search entire string (do not stop after first occurence): g
      false
    else if /[\+\-\*\/]{2}/g.test @sanetizedInput # Use of dobble operators
      # Regular expression used
      # Any of the characters: [...]
      # Characters: +, -, * or / (math operators)
      # Placed before a non-digit: \D
      # Search entire string (do not stop after first occurence): g
      false
    else if  /[\+\-\*\/]$/g.test @sanetizedInput # Use of operator at the end of line
      # Regular expression used
      # Any of the characters: [...]
      # Characters: +, -, * or / (math operators)
      # At the end of the string: $
      # Search entire string (do not stop after first occurence): g
      false    
    else
      true
      
  errorsInInput: ->
    if @isValidInput()
      []
    else
      # TODO: Expand error messages with details about invalid characters
      ["Invalid input. The input includes some weird characters. It can only include digits, +, -, *, / and brackets ()."]

  calculateValidInput: ->
    if /^[\+\-\*\/]/g.test @sanetizedInput # check for + - * / characters in the first position
      eval @base + @sanetizedInput
    else
      eval @sanetizedInput

  @split: (number, parts) -> 
    number = parseFloat(number)
    parts = parseInt(parts)
    amount = number / parts

    if isFinite(amount)
      amount
    else
      0


root.Calculator = Calculator

calc = new Calculator '+5', 100
console.log calc.result()