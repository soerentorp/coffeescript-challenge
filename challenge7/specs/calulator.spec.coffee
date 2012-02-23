{Calculator} = require './../Calculator'

# For Jasmine help API:
# https://github.com/pivotal/jasmine/wiki/Suites-and-specs
# https://github.com/pivotal/jasmine/wiki/Matchers
# https://github.com/pivotal/jasmine/wiki/Before-and-After
# https://github.com/pivotal/jasmine/wiki/Spies
# https://github.com/pivotal/jasmine/wiki/Asynchronous-specs
#
# Official Jasmine site: 
# http://pivotal.github.com/jasmine/

describe 'Calculator', ->
  errorMessages = ["Invalid input. The input includes some weird characters. It can only include digits, +, -, *, / and brackets ()."]
  
  describe '#result', ->
    describe 'when a single input is parsed to the calculator', ->
      it 'can add', ->
        calculator = new Calculator('2+3')
        expect(calculator.result()).toEqual 5
      it 'can subtract', ->
        calculator = new Calculator('3-2')
        expect(calculator.result()).toEqual 1
      it 'can multiply', ->
        calculator = new Calculator('2*3')
        expect(calculator.result()).toEqual 6
      it 'can divide', ->
        calculator = new Calculator('3/2')
        expect(calculator.result()).toEqual 1.5
      it 'can use brackets', ->
        calculator = new Calculator('200 / (1 + 1)')
        expect(calculator.result()).toEqual 100
      it 'can use multiple operands (Challenge 6 pass!)', ->
        calculator = new Calculator('200 - 23 + 2 * 34')
        expect(calculator.result()).toEqual 245
      it 'throws an error when letters are included in input string', ->
        calculator = new Calculator('a+3')
        #expect(-> calculator.result()).toThrow new Error errorMessages
        calculator.result()
        expect(calculator.errorsInInput()[0]).toContain 'odd characters'
      it 'throws an error when illegal symbols are included in the input string', ->
        calculator = new Calculator('2&3?!')
        #expect(-> calculator.result()).toThrow new Error errorMessages
        calculator.result()
        expect(calculator.errorsInInput()[0]).toContain 'odd characters'
      it 'throws an error when one legal operator is followed by another in the input string', ->
        calculator = new Calculator('2++5')
        #expect(-> calculator.result()).toThrow new Error errorMessages
        calculator.result()
        expect(calculator.errorsInInput()[0]).toContain 'adjacent operators'
      it 'throws an error when legal operators are not followed by a digit in the input string', ->
        calculator = new Calculator('2+')
        #expect(-> calculator.result()).toThrow new Error errorMessages
        calculator.result()
        expect(calculator.errorsInInput()[0]).toContain 'ends with an operator'
      xit 'throws an error when brackets are not in pairs in the input string', ->
        calculator = new Calculator('2+(5+2')
        #expect(-> calculator.result()).toThrow new Error errorMessages
        expect('pending').toEqual('completed')
      it 'throws an error when illegal symbols and adjacent operators are included in the input string', ->
        calculator = new Calculator('2&3++?!')
        #expect(-> calculator.result()).toThrow new Error errorMessages
        calculator.result()
        expect(calculator.errorsInInput()[0]).toContain 'odd characters'        
        expect(calculator.errorsInInput()[1]).toContain 'adjacent operators'        
  
    describe 'when input and total are parsed to the calculator', ->
      describe 'when plus (+) is the first input letter', ->
        it 'adds input to total', ->
          calculator = new Calculator('+5',100)
          expect(calculator.result()).toEqual 105
      describe 'when minus (-) is first input letter', ->
        it 'subtracts input from total', ->
          calculator = new Calculator('-5',100)
          expect(calculator.result()).toEqual 95
      describe 'when multiple (*) is first input letter', ->
        it 'multiplies input with total', ->
          calculator = new Calculator('*5',100)
          expect(calculator.result()).toEqual 500      
      describe 'when divide (/) is first input letter', ->
        it 'divides total with input', ->
          calculator = new Calculator('/5',100)
          expect(calculator.result()).toEqual 20 
        it 'returns 0 if the dividend is 0 (althought it does not follow math conventions)', ->
          calculator = new Calculator('/0',100)
          expect(calculator.result()).toEqual 0
      describe 'when white space is included', ->
        it 'ignores it', ->
          calculator = new Calculator('+ 50 / 2',100)
          expect(calculator.result()).toEqual 125
          
  describe '#isValid', ->
    describe 'when input is valid', ->
      calculator = new Calculator('2 + 3')
      it 'returns true', ->
        expect(calculator.isValid()).toEqual true
    describe 'when input is invalid', ->
      calculator = new Calculator('a+3')
      it 'returns false', ->
        expect(calculator.isValid()).toEqual false
        
  describe '#errorsInInput', ->
    describe 'when input is valid', ->
      calculator = new Calculator('2 + 3')
      it 'returns empty array', ->
        expect(calculator.errorsInInput()).toEqual []
    describe 'when input is invalid', ->
      calculator = new Calculator('a+3')
      xit 'returns array (with error messages)', ->
        expect(calculator.errorsInInput()).toEqual errorMessages

  # Spec you old split_amount method. Note: I have renamed it to split.
  describe '.split', ->
    it 'splits a number into a given number of parts', ->
      expect(Calculator.split(100, 2)).toEqual 50

    it '4.1) returns 0 for (0, 0)', ->
      expect(Calculator.split(0,0)).toEqual 0

    it '4.2) returns 5 for (\"10\", \"2\")', ->
      expect(Calculator.split("10","2")).toEqual 5

    it '5.1) returns 0 for (\"\", \"\")', ->
      expect(Calculator.split("","")).toEqual 0

    it '5.2) returns 0 for (null, 3)', ->
      expect(Calculator.split(null,3)).toEqual 0

    it '5.3) returns 0 for (100, null)', ->
      expect(Calculator.split(100,null)).toEqual 0

    it '5.4) returns 50.25 for (100.5, 2)', ->
      expect(Calculator.split(100.5, 2)).toEqual 50.25

    it '5.5) returns 0 for (\"a12\", 2)', ->
      expect(Calculator.split("a12",2)).toEqual 0
