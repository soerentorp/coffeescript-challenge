root = exports ? window

class Utility
  # You don't need a constructor in this case, because we're only using split_amount as a class method.
  # constructor(total, number_of_people) ->

  # Very close! You just need to add a @-sign in front of the method, to make it a class method.
  #
  # If it isn't a class method, but an instance method, you have to call the method on an object of class Utility:
  # utility = new Utility() # Now we have an object
  # utility.split_amount(100, 5)
  #
  # When it is defined as a class method, you can call your method directly on the Utility class:
  # Utility.split_amount(100, 5)
  
  @split_amount: (total, number_of_people) -> 
    number_of_people = parseInt(number_of_people)
    total = parseFloat(total)
    amount = total / number_of_people

    if isFinite(amount)
      amount
    else
      0

root.Utility = Utility
