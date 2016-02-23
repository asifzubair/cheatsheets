# Design of Computer Programs #

my notes from udacity's [design of computer programs](https://www.udacity.com/course/design-of-computer-programs--cs212) course taught by [peter norvig](http://norvig.com/). Peter's [list](http://norvig.com/ipython/README.html) of ipython notebooks are a thing of interest.  

## Lecture 1 ##

this lecture deals with a random shuffling and comparing of poker hands.  

There are two data structures used: sets and tuples.

The `set()` function is used for identifying all the unique elements in an iterable object (like a `list`). For example:  

```python
>>> myset = set(['one','two','three','two','one']) 
>>> myset set(['three', 'two', 'one'])
```

There are two interesting things to note here: 
- `set()` doesn't keep duplicate copies 
- `set()` is unordered. 
to read more about sets, take a look at the [Python documentation](http://docs.python.org/library/stdtypes.html#set).  

The second data structure is a tuple. think of a tuple as an `immutable` (unchangeable) `list`, but to learn more look at [this](http://docs.python.org/tutorial/datastructures.html#tuples-and-sequences) description of python data structures.  

defining hands:
```python
sf = "6C 7C 8C 9C TC".split() 
fk = "9D 9H 9S 9C 7D".split() 
fh = "TD TC TH 7C 7D".split()
```

```python
>>> print max([3,4,5,0]), max([3,4,-5,0], key=abs)
5 -5
```

creating a 100 element list:
```python
import random

## randomly sample from list of hands
assert poker([random.choice([sf, fk, fh]) for i in xrange(100)]) == sf
## create  concatenated list of 100 hands
assert poker([sf] + 99*[fk]) == sf
```

lexicographic ordering to compare tuples - `(7,9,5) > (7,3,2)`  

