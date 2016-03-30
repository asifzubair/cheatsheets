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

## Shuffling ##

python function for shuffle:
```python
import random
random.shuffle()
```

some versions of shuffle:
```python
def swap(deck, i, j):
    "Swap elments i and j of a collection."
    print 'swap', i, j
    deck[i], deck[j] = deck[j], deck[i]

def bad_shuffle(deck):
    " inefficient and unfair"
    N = len(deck)
    swapped = [False] * N
    while not all(swapped):
        i, j = random.randrange(N), random.randrange(N)
        swapped[i] = swapped[j] = True
        swap(deck, i , j)

def better_shuffle(deck):
    "still inefficient, but fair"
    N = len(deck)
    swapped = [False] * N
    while not all(swapped):
        i, j = random.randrange(N), random.randrange(N)
        swapped[i] = True
        swap(deck, i , j)

def shuffle(deck):
    "Knuth's Algorithm P"
    N = len(deck)
    for i in xrange(N-1):
        swap(deck, i, random.randrange(i, N))
        ## common mistake to have this as random.randrange(N)
        ## not correct
```

testing shuffles:
```python
def test_shuffler(shuffler, deck='abcd', n=10000):
    counts = defaultdict(int)
    for _ in xrange(n):
        input = list(deck)
        shuffler(input)
        counts[''.join(input)] += 1
    e = n*1./factorial(len(deck)) ## expected count
    ok = all((0.9 <= counts[item]/e <= 1.1) for item in counts)
    name = shuffler.__name__
    print '%s(%s) %s' % (name, deck, ('ok' if ok else '*** BAD ***'))
    print '    '
    for item, count in sorted(counts.items()):
        print "%s:%4.1f" % (item, count*100./n),
    print

def test_shufflers(shufflers=[shuffle, shuffle1], deck=['abc', 'ab']):
    for deck in decks:
        print
        for f in shufflers:
            test_shuffler(f, deck)

def factorial(n): return 1 if (n<=1) else n*factorial(n-1)
```
