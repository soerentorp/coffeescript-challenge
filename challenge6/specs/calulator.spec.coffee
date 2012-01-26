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

  # Implement this new feature
  describe '#result', ->
    it 'can add', ->
      calculator = new Calculator('2+2')
      expect(calculator.result()).toEqual 4
    it 'can multiply', ->
    it 'can divide', ->
    it 'returns 0 when letters are included in input string', ->
    it 'returns 0 when illegal symbols are included in input string', ->
    # ...

  # Spec you old split_amount method. Note: I have renamed it to split.
  describe '.split', ->
    it 'splits a number into a given number of parts', ->
      expect(Calculator.split(100, 2)).toEqual 50

    it 'returns 0 when...', ->
    # ...
