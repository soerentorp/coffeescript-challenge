Challenge 6 — Make input fields computable
======

In this challenge you're going to implement a calculator we can use to make input fields computable. This way people can type in fx:

    200 - 23 + 2 * 34

and get the result right away instead of pulling out their own calculator.

Test setup
------
For this challenge you're going to test you code with Jasmine instead of printing to the console. We're going to have a very simple setup that lets you run your tests in the console.

To make this work, you need to install jasmine node. So fire up your terminal and type:

    cd <path to challenge6>
    npm install jasmine-node

To see if it works, just type:

    jasmine-node

It should return something like this:

    SAGE: jasmine-node [--color|--noColor] [--verbose] [--coffee] directory

    Options:
      --color            - use color coding for output
      --noColor          - do not use color coding for output
      .
      .
      .

If not. Call for help ;-)

Running the tests
------

To run you test, inside the `challenge6` dir, type:

    jasmine-node --coffee specs

This tells the jasmine-node program at we use coffeescript and our `specs` dir.

You should see:

    Finished in 0.002 seconds
    7 tests, 2 assertions, 0 failures

Otherwise call for help ;-)

The challenge
------

Now you're ready to start hacking. Look inside `specs/calulator.spec.coffee` where you'll find the skeleton for writing the specs. 
You should implement the specs that are empty, and make them pass by implementing the code in `calculator.coffee`.
You should also spec your old `split_amount` method and move it into the calculator.

You get extra credit for implementing cool new features to the calculator, that you would love to use your self.

Good luck!
