# Lecture 2 #

List Comprehensions: 
```python
[s for r,s in cards
    if r in 'JQK'
    for ...
    if ...
    for ...
    for ...
]
```
Generator Expressions:
```python
>>> def sq(x): print 'sq called', x; return x*x
... 
>>> g = (sq(x) for x in range(10) if x%2 == 0)
>>> g
<generator object <genexpr> at 0x1007cbf00>
>>> next(g)
sq called 0
0
>>> for _ in (sq(x) for x in range(10) if x%2 == 0): pass
... 
sq called 0
sq called 2
sq called 4
sq called 6
sq called 8
```
some reasons to use generators:
- less indentation
- stop early
- easier to edit

generator functions:
```python
def ints(start, end=None):
    i = start
    while i <= end or end is None:
        yield i
        i += 1
"""
L = ints(0, 1000000)
L = <generator>
next(L)
"""
def all_ints()
    "Generate ints in the order 0, +1, -1, +2, -2..."
    yield 0
    i = 1
    while True:
        yield i
        yield -i
        i += 1
```

for statements:
```python
for x in items:
    print x

"""
for statements use an iterable, 
in this case 'items' and
translate to soemthing like this:
""""
it = iter(items)
try:
    while True:
        x = next(it)
        print x
except StopIteration:
    pass
```
zebra puzzle:
```python
import itertools

def imright(h1, h2):
    "House h1 is immediately right of h2 if h1-h2 == 1."
    return h1-h2 == 1

def nextto(h1, h2):
    "Two houses are next to each other if they differ by 1."
    return abs(h1-h2) == 1

def c(sequence):
    """Generate items in sequence; keeping counts as we go.
    c.starts is the number of sequences started; 
    c.items is number of items generate."""
    c.starts += 1
    for item in sequence:
        c.items += 1
        yield item

def zebra_puzzle():
    "Return a tuple (WATER, ZEBRA indicating their house numbers."
    houses = first, _, middle, _, _ = [1, 2, 3, 4, 5]
    orderings = list(itertools.permutations(houses)) # 1
    return next((WATER, ZEBRA)
                for (red, green, ivory, yellow, blue) in c(orderings)
                if imright(green, ivory)
                for (Englishman, Spaniard, Ukranian, Japanese, Norwegian) in c(orderings)
                if Englishman is red
                if Norwegian is first
                if nextto(Norwegian, blue)
                for (coffee, tea, milk, oj, WATER) in c(orderings)
                if coffee is green
                if Ukranian is tea
                if milk is middle
                for (OldGold, Kools, Chesterfields, LuckyStrike, Parliaments) in c(orderings)
                if Kools is yellow
                if LuckyStrike is oj
                if Japanese is Parliaments
                for (dog, snails, fox, horse, ZEBRA) in c(orderings)
                if Spaniard is dog
                if OldGold is snails
                if nextto(Chesterfields, fox)
                if nextto(Kools, horse)
                )

import time

def timedcall(fn, *args):
    "Call function with args; return the time in seconds and result."
    t0 = time.clock()
    result = fn(*args)
    t1 = time.clock()
    return t1-t0, result

def average(numbers):
    "Return the average (arithmetic mean) of a sequence of numbers."
    return sum(numbers) / float(len(numbers)) 

def timedcalls(n, fn, *args):
    """Call fn(*args) repeatedly: n times if n is an int, or up to
    n seconds if n is a float; return the min, avg, and max time"""
    if isinstance(n, int):
        times = [timedcall(fn, *args)[0] for _ in xrange(n)]
    else:
        times = []
        while (sum(times) <= n):
            times.append(timedcall(fn, *args)[0])
    return min(times), average(times), max(times)
```
