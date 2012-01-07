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
	total = parseInt(total)
	
	if number_of_people > 0
		total / number_of_people
	else
		0

# For bonus points, include what you expect your method to return in your output.
# Good luck :-)

# Test:
# ...

