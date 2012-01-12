root = exports ? window

class Calculator
  constructor: (@input) ->

  result: ->
    eval @input

  @split: (number, parts) -> 
    number / parts

root.Calculator = Calculator
