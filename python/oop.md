[How to declare default values for instance variables in Python?](http://stackoverflow.com/questions/2681243/how-should-i-declare-default-values-for-instance-variables-in-python)

First, this is okay:  
```python
>>> class TestB(): 
...   def __init__(self, attr=1): 
...     self.attr = attr 
... 
>>> a = TestB() 
>>> b = TestB() 
>>> a.attr = 2 
>>> a.attr 
2 
>>> b.attr 
1
```  
However, this only works for **immutable** types. If the default value was **mutable**, this would happen instead:  
```python
>>> class Test(): 
...   def __init__(self, attr=[]): 
...     self.attr = attr 
...
>>> a = Test() 
>>> b = Test() 
>>> a.attr.append(1) 
>>> a.attr 
[1] 
>>> b.attr 
[1] 
>>> 
```  
Note both `a` and `b` have a shared attribute. This is often unwanted.  

This is the **Pythonic** way of defining default values for instance variables, when the type is mutable:
```
>>> class TestC(): 
... 	def __init__(self, attr=None): 
...   	if attr is None: 
...     	attr = [] 
... 	  self.attr = attr 
... 
>>> a = TestC() 
>>> b = TestC() 
>>> a.attr.append(1) 
>>> a.attr [1] 
>>> b.attr []
```
The reason the first snippet of code works is because, with immutable types, Python creates a new instance of it whenever you want one. If you needed to add 1 to 1, Python makes a new 2 for you, because the old 1 cannot be changed. The reason is probably for hashing.

---

```python
###
# Scalable method to define setter and getters
###

class Duck:
	def __init__(self, **kwargs):
		self.variables = kwargs
		
"""
	## example for single attribute type
	
	def set_color(self, color):
		self.variables['color'] = color
	
	def get_color(self, color):
		return self.varibales.get('color', None)
"""

	def set_variable(self, k, v):
		self.variable[k] = v
	
	def get_variable(self, k):
		return self.variables.get(k, None)
	
def main():
	donald = Duck(feet = 2)
	print donald.get_variable('feet')
	print donald.get_variable('color')

###### Python's dict interface

def keys(self):
	return self._keys

def __setitem__(self, key):
	self.set(key, value)

def __getitem__(self, key):
	return self.get(key)

def __delitem__(self, key):
	return self.remove(key)

def __repr__(self):
	return '{ ' + ', '.join([key + ':' + str(self.get(key)) for key in self._keys]) + '}'
```
