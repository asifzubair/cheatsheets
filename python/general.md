# General #


**Package Management**

[SO](http://stackoverflow.com/questions/6344076/differences-between-distribute-distutils-setuptools-and-distutils2) has a great answer (as of 2014) for what the are the differences between `setuptools` etc. Also, the [Python Package User Guide](https://python-packaging-user-guide.readthedocs.org/en/latest/index.html) is a great resource.

**Style Guides**

Python style guide by [google](https://google.github.io/styleguide/pyguide.html).  

Also, really helpful [SO](http://stackoverflow.com/questions/14328406/tool-to-convert-python-code-to-be-pep8-compliant) post on testing if your code is [PEP8](https://www.python.org/dev/peps/pep-0008/) compliant. Can use a module called [pep8](https://github.com/PyCQA/pep8) itself to check if code is compliant. [autopep8](https://pypi.python.org/pypi/autopep8) can be used to change PEP8 violations that don't change meaning of the code. There is **aggressive** mode as well, but use at own risk. 

---

* Keywords and Functions

  * `kwargs`
  * The `**kwargs` will give you all keyword arguments except for those corresponding to a formal parameter as a dictionary.

```
	def colorbar_index(ncolors, cmap, labels=None, **kwargs):
		...
		
		colorbar = plt.colorbar(mappable, **kwargs)
		colorbar.set_ticks(np.linspace(0, ncolors, ncolors))
		
		...
```
* [yield](http://stackoverflow.com/questions/231767/what-does-the-yield-keyword-do-in-python)

* `eval`: evaluate any string: 
```
		code = "1 + 1"
		eval(code)
```

* use [enumerate](http://stackoverflow.com/questions/1540049/replace-values-in-list-using-python) 
* `filter`

* if, else in list comprehension - with unicode characters  
```
columns = [unicodedata.normalize('NFKD', s).encode('ascii','ignore') if isinstance(col, unicode) else col for col in columns]
```
NEED to find out what [NKFD](http://www.peterbe.com/plog/unicode-to-ascii ) is above  

• `[0]*100` will print a list with 100 zeros

* OS module
```  
import os 
print os.environ['HOME']
# os.getenv can give a default value instead of 'None'
print os.getenv('KEY_THAT_MIGHT_EXIST', default_value)
```

* `psycopg2`  
  * `conn = pg2.connect(**json.load(open('/home/azubair/psql.password')))`
	
* Defining connection string with settings file
```
import psycopg2 as pg2 
import settings
conn = pg2.connect('host={db.DB_HOST} user={db.DB_USER} dbname={db.DB_NAME} password={db.DB_PASSWD}'.format(db=settings))
```
**Warning:** Never, never, NEVER use Python string concatenation (+) or string parameters interpolation (%) to pass variables to a SQL query string. Not even at gunpoint.  
* The correct way to pass variables in a SQL command is using the second argument of the `execute()` method:

```
>>> SQL = "INSERT INTO authors (name) VALUES (%s);" 
# Note: no quotes 
>>> data = ("O'Reilly", ) 
>>> cur.execute(SQL, data) 
# Note: no % operator
```

* File I/O  
```
with open('someFile.txt', 'r')  as f:
	line = f.readline()  
	while line != '': 
		print line, # Process the line in; in this case, just print it out 
		line = f.readline() # Get next line 

with open('someFile.txt', 'r') as f:
	for line in f.readlines():
    		print line, 
```  

* Concatenate two `numpy` arrays in the 4th dimension

``` 
import numpy as np 
a = np.ones((3,4,5))
b = np.ones((3,4,5))
c = np.concatenate((a[...,np.newaxis],b[...,np.newaxis]),axis=3)
```

* Is it possible to get a list of `keywords` in Python?

```
>>> import keyword
>>> keyword.kwlist
['and', 'as', 'assert', 'break', 'class', 'continue', 'def', 'del', 'elif',
'else', 'except', 'exec', 'finally', 'for', 'from', 'global', 'if', 'import',
'in', 'is', 'lambda', 'not', 'or', 'pass', 'print', 'raise', 'return', 'try',
'while', 'with', 'yield']
```

```
"""Count words."""

from collections import Counter

def count_words(s, n):
    """Return the n most frequently occuring words in s."""
    
    words = s.split()
    word_counts = Counter(words).items()
    top_n = sorted(word_counts, key = lambda x: (-x[1],x[0]))
    
    return top_n[:n]

def test_run():
    """Test count_words() with some inputs."""
    print count_words("cat bat mat cat bat cat", 3)
    print count_words("betty bought a bit of butter but the butter was bitter", 3)

if __name__ == '__main__':
    test_run()
```
