# Challenge 4
#
# Edit the split_amount method so that it handles the following edge cases:
# 1) split_amount(0, 0) should equal 0
# 2) split_amount("10", "2") should equal integer 5. Note that strings are parsed to the method.
# hint: parseInt("1") converts the string to an integer 

split_amount = (total, number_of_people) -> total / number_of_people

