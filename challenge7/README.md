Challenge 7 — Handle invalid input
======

You passed challenge 6 with flying colors! Well done! You have used specs very well to document and verify the calcular's behavior. As you'll see in your spec file, I have restructered your specs a little bit.

In this challenge you're going to make the calculator bulletproof, so invalid input is handled gracefully. 
In the calculator.coffee file there is a new method called isValid. It is your job to implement it so fx:

    calculator = new Calculator "//3", "100"
    calculator.isValid() # returns false

A good pattern for this type of job is to use "whitelisting". That means you specify what is valid input and reject everything else.
The opposite is called "blacklisting". This is where you specify what is invalid input and accept everything else. The weakness of blacklisting is that you would have to come up with every single thing that would not be valid.


Demo the calculator in the browser
------
You can try out your calculator in the browser. Just open the index.html file. Type in something in the input field and hit enter. It should write the result next to the result label.

If not; call for help.

Good luck!
