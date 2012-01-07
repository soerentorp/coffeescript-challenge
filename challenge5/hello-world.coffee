# Challenge 5
#
# Edit the split_amount method so that it handles the following edge cases:
# 1) split_amount("", "") should equal 0
# 2) split_amount(null, 3) should equal 0
# 3) split_amount(100, null) should equal 0
# 4) split_amount(100.5, 2) should equal 50.25
# 5) split_amount("a12", 2) should equal 0

# hint: you can play around with coffee script in the console. Just type coffee in your terminal. A coffeescript console is then loaded where you can type coffeescript commands and do calculations. Programmers call this REPL (read–eval–print loop).

split_amount = (total, number_of_people) -> 
	number_of_people = parseInt(number_of_people)
	total = parseFloat(total)
	amount = total / number_of_people
	
	if isFinite(amount)
		amount
	else
		0

# For bonus points, include what you expect your method to return in your output.
# Good luck :-)

# Test:
console.log "================== CHALLENGE 4 - Test of Edge Cases ================="
console.log "1) split_amount(0, 0) should equal              0" + " / " + split_amount(0,0) + " is the result"
console.log "2) split_amount(\"10\", \"2\") should equal integer 5" + " / " + split_amount("10","2") + " is the result"
console.log "================= End of Test - CHALLENGE 4         ================="
console.log ""
console.log "================== CHALLENGE 5 - Test of Edge Cases ================="
console.log "1) split_amount(\"\", \"\") should equal     0" + " / " + split_amount("", "") + " is the result"
console.log "2) split_amount(null, 3) should equal    0" + " / " + split_amount(0, 3) + " is the result"
console.log "3) split_amount(100, null) should equal  0" + " / " + split_amount(100, null) + " is the result"
console.log "4) split_amount(100.5, 2) should equal   50.25" + " / " + split_amount(100.5,2)  + " is the result"
console.log "5) split_amount(\"a12\", 2) should equal   0" + " / " + split_amount("a12", 2) + " is the result"
console.log "================= End of Test - CHALLENGE 5         ================="

# Very nice! You just earned +10 extra credit bonus points. Good job!

# ===============================================================================
# Challenge 5 continued (advanced)
# ===============================================================================
#
# In a class inside the tally.io app, we would like to use your method. It would therefore be nice if we could include your code likes this:
# {Utility} = require './Utility'
#
# and call your method like this:
# Utility.split_amount(100, 5)
#
# This will give us a very nice sepration of concerns (decoupling) and a nice place where we can maintain our utility methods.
#
# Can you think of a way to do this? You are encourage to create two new files. One where you put your method and another one where you show how to use your method.
#
# hint: The skeleton code of your utility file should look something like this:
# =================================
# root = exports ? window # Don't worry to much about this yet. It sets the global variable root to either exports or window depending on whether you're running your code in the command line (through NodeJS) or in a browser.
#  
# ' you fill this out
#
# root.Utility = Utility # Makes your utility file available to other files.
# =================================
