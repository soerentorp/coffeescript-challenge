root = exports ? window

class Calculator
  constructor: (@input, @base) ->
    @sanetizedInput = @sanetizeInput @input
    @errors = [] # Array of error messages
    @resultValue = null
      
  isValid: ->
    @isValidInput() # for now, the input determines whether we are ready to go
      
  result: ->
    return @resultValue if @resultValue? # Return the value if it has already been calculated
    if @isValidInput()
      result = @calculateValidInput()
      if isFinite(result) then result else 0 # check if calculation makes sense
    else
      throw @errorsInInput() # Throw an exception for the programmer

  sanetizeInput: (input) ->
    input.replace(/\s/g, "") # remove white spaces

  isValidInput: ->
    @resetErrors() # to avoid duplicated error messages
    regexContainsInvalidCharacters = /// # The string contains invalid characters (is there a character which is neither of the following?) -
      [ # - if the individual character is -
        ^\d # not a digit (0-9) and
        ^\+ # not a plus (+) and
        ^\- # not a minus (-) and
        ^\* # not a star (*) and
        ^\/ # not a slash (/) and
        ^\. # not a dot (.) and
        ^\( # not an open bracket "(" and
        ^\) # not a close bracket ")"
      ]
    /// 
    regexContainsAdjacentOperators = /// # The string contains invalid use of operators -
      [ # - if the individual character is -
        \+ # a plus (+) or
        \- # a minus (-) or
        \* # a star (*) or
        \/ # a slash (/)
      ]
      {2} # two characters in a row (=adjacent to each other)
    ///
    regexContainsOperatorAtEnd = /// # The string contains invalid use of an operator at the end -
      [ #   - if the character is -
        \+ #  a plus (+) or
        \- #  a minus (-) or
        \* #  a star (*) or
        \/ #  a slash (/)
      ]
      $ #   - at the end of the string
    ///
    isValid = true
    if regexContainsInvalidCharacters.test @sanetizedInput # Use of invalid characters
      isValid = false
      @addError 'Invalid input. The input includes some odd characters. It can only include digits (0-9), plus (+), minus (-), star (*), slash (/) and brackets "(" or ")."'
    if regexContainsAdjacentOperators.test @sanetizedInput # Use of adjacent operators
      isValid = false
      @addError 'Invalid input. The input includes two adjacent operators (+, -, * or /) which the calculator do not know how to handle.'
    if regexContainsOperatorAtEnd.test @sanetizedInput # Use of operator at the end
      isValid = false
      @addError 'Invalid input. The input ends with an operator (+, -, * or /). The calculator does not know how to handle this. Would you?'
    try
      @resultValue = @calculateValidInput()
    catch error
      @addError "You did something crazy that Cal does not know how to handle. '#{error.toString()},' he says."
      isValid = false
    finally
      return isValid
      
  errorsInInput: ->
    @errors
    
  addError: (errorMessage) ->
    @errors.push errorMessage
    #console.log 'Error recorded for ' + @input + ' (' + errorMessage + ')'
    
  resetErrors: ->
    @errors = []

  calculateValidInput: ->
    if /^[\+\-\*\/]/.test @sanetizedInput # check for + - * / characters in the first position TODO: Make more strutable
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