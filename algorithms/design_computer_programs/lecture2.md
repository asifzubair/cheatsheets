# Lectrue 2 #

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
