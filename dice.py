# Rolling dice

import random

def rollDice(n):
    total = 0
    for i in range(n):
        total = total + random.randint(1, 6)

    return total

rollDice(3)
