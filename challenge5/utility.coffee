root = exports ? window

class Utility
  constructor(total, number_of_people) ->

  split_amount: (total, number_of_people) -> 
    number_of_people = parseInt(number_of_people)
	total = parseFloat(total)
	amount = total / number_of_people

	if isFinite(amount)
		amount
	else
		0

root.Utility = Utility