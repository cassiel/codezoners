# Getting started in Python. We want to emulate the rolling of dice.

# We need the standard library for generating random numbers:

import random

# One die (a random integer between 1 and 6 inclusive):
random.randint(1, 6)

# Two dice (written rather long-windedly):
random.randint(1, 6) + random.randint(1, 6)

# A brief diversion: this is a list of numbers, starting at zero:
range(15)
# (The range includes the starting value, but not the end value.)


# The range can start at a value other than zero (two arguments:
# the starting value and the limit):
range(15, 20)
range(-5, 10)

# The range can have an interval other than 1: the interval is the
# third argument:
range(10, 20, 2)

# The interval can be negative, to count backwards:
range(10, -10, -2)

# For-loop: let's print every value in a range. (Printed output can
# be seen by selecting "Console" from the View menu, or clicking the
# number - the number of lines printed -at the bottom right of
# this window.)
for i in range(10):
    print(i)

# Dice-throwing: to throw n dice, add each throw's random value
# to a total:
def throwDice(n):
    total = 0

    for i in range(n):
        total = total + random.randint(1, 6)

    return total

# A functional version, using recursion: to throw n dice, add
# the value of a single throw to the result of throwing (n - 1)
# dice:
def throwDice(n):
    if n == 0:
        return 0
    else:
        return random.randint(1, 6) + throwDice(n - 1)

# Try it. (In Python, this recursive version will run out of stack
# space for greater than modest values of n.)
throwDice(10)
