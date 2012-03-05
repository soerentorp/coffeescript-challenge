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
    sanetizedInput = input
    sanetizedInput = sanetizedInput.replace(/\s/g, "") # remove white spaces (spaces, tabs, and line breaks)
    #if /\./.test(sanetizedInput) and /\,/.test(sanetizedInput) # both a dot (.) and a comma (,)?
      #console.log "Bingo, we've got a problem. (#{sanetizedInput})" # We got a problem
    sanetizedInput = @sanetizeDotsAndCommas(sanetizedInput)
    sanetizedInput

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
      @addError "Invalid input. The input includes some odd characters. It can only include digits (0-9), plus (+), minus (-), star (*), slash (/) and brackets \"(\" or \").\""
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
    
  # ------------- FUNCTIONS FOR SANITIZING INPUT -------------------- >>>
  sanetizeDotsAndCommas: (input) ->
    numbers = []
    sanetizedInput = input
    numbers = @numbersInString(input)
    #console.log numbers
    for number in numbers
      sanetizedNumber = @numberWithOneOrNoDelimiter(number)
      if (isCriticalNumber = @isCriticalNumber(sanetizedNumber))
        if not @isProbableNumber(sanetizedNumber)
          numberWitoutDecimal = @numberWitoutDecimal(sanetizedNumber)
          if @isProbableNumber(numberWitoutDecimal)
            sanetizedNumber = numberWitoutDecimal
      sanetizedInput = sanetizedInput.replace(number,sanetizedNumber)
      #console.log "'#{number}' #{@partBeforeDecimal(number)}+#{@partFromDecimal(number)} result: #{sanetizedNumber} (is critical? #{isCriticalNumber} / same delimiter? #{@sameDelimiterUsedMultpleTimes(number)})"
    #console.log "FINAL sanitized string: #{sanetizedInput}"
    sanetizedInput
    
  numbersInString: (input) ->
    regexOperators = ///
      [\+\-\*\/]
      ///g
    String(input).split(regexOperators)
    
  numberWithOneOrNoDelimiter: (input) ->
    if @sameDelimiterUsedMultpleTimes(input)
      @removeByRegex(input,/[\.\,]/g)
    else
      @partBeforeDecimal(input) + @partFromDecimal(input)
    
  sameDelimiterUsedMultpleTimes: (input) ->
    if (/\..*\./g.test(input) and not /\,/.test(input)) # if one dot is followed by another without any commas involved
      true
    else if (/\,.*\,/g.test(input) and not /\./g.test(input)) # if or one comma by another without any dots
      true
    else
      false 
    
  partFromDecimal: (input) ->
    regexFirstDecimaFromRight = /[\.\,]\d*$/ # ASK: Should be global variable?
    part = regexFirstDecimaFromRight.exec input
    sanetizedPart = part.toString().replace(/[\,]/g,'.') if part? # dots are used as decimals by standard
    if sanetizedPart? then sanetizedPart else ''
        
  partBeforeDecimal: (input) ->
    regexFirstDecimaFromRight = /[\.\,]\d*$/ # ASK: Should be global variable?
    part = @removeByRegex(input,regexFirstDecimaFromRight)
    sanetizedPart = @removeByRegex(part,/[\,\.]/g) # remove all potential decimals (dots or commas)
    if sanetizedPart? then sanetizedPart else ''
    
  removeByRegex: (input, regex) ->
    input.toString().replace(regex,'') if input?
    
  isCriticalNumber: (input) ->
    regexCriticalNumber = ///
      \d+ # one or more digits
      [\.\,] # and a dot (.) or comma (,)
      \d{3} # and 3 digits
      ///
    regexCriticalNumber.test input
    
  numberWitoutDecimal: (input) ->
    input.replace(/[\,\.]/g,'')
    
  isProbableNumber: (number) -> # A subjective estimate of whether the number is within a reasonable interval
    bottomBoarder = 2 # equalling and interval between 2 and 2000 in the used currency ASK: Global variable to be set when the Calculator is setup on site?
    topBoarder = bottomBoarder * 1000
    number >= bottomBoarder and number < (topBoarder)

  # <<< --------- FUNCTIONS FOR SANITIZING INPUT ------------------------
  
  
  formattedResult: (decimalPlaces) ->
    @format @result(@input), decimalPlaces

  format: (number,decimalPlaces) ->
    @addDelimiters @roundNumber(number,decimalPlaces)
    
  roundNumber: (number,decimalPlaces = 2) ->
    number.toFixed(decimalPlaces)  
    
  addDelimiters: (number) ->
    regexSplitByThirdDigit = ///
      (?= # zero-width positive lookahead ("Matches only the position. It does not consume any characters or expand the match." /regular-expressions.info)
        (?: # do not create a backreference so that the content can be used later in regex or e.g. replacement
          \d{3} # three digits
        )
        + # one or more
        (?: # do not create a backreference so that the content can be used later in regex or e.g. replacement
          \. # dot
          | # or
        $) # end of string
      )
      ///g
    number.toString().split(regexSplitByThirdDigit).join( "," )
    
  
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