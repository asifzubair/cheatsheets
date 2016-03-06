# Pandas #

* when reading into `pandas` better to specify `dtype` especially `datetime` at READ time. 
 
* `print df.reset_index().to_json(orient='records')` - for `json` without indices 
 
* `a = pd.read_json(x, typ='series', orient='records')` - to read `json` in `pandas` 
 
* `groupby` returns a `groupby` object. | `set_index()` | `reindex()`  

* read/write from a PostgreSQL  
`pd.readsql(SQL_STATEMENT, conn)`  
for WRITE, specify DB type from `SQLAlchemy` 
 
```python
import pandas.io.sql as psql  
from sqlalchemy import create_engine  
engine = create_engine(r'postgresql://some:user@host/db')  
c = engine.connect()  
conn = c.connection  
df = psql.read_sql("SELECT * FROM xxx", con=conn)  
df.to_sql('a_schema.test', engine)  
conn.close() 
```

`read.csv()` can have a specific RE delimiter  

`\s{4,}|\.\d{2,2}\s{2,2}W` => strange beast but just means match either "4 whitespaces or more" OR an expression like this ".23  W" 
 
* indexing
`iloc` is MUCH MUCH faster than `ix`   
`df.iloc[rowNumber,:]` & `df.ix[rowNumber,:]` give same output.  
there does seem to be a restriction with `.iloc` in that indices are required and column names can't be used. MUST VERIFY.  
 
* How to do pivoting ? 
 
[Difference](http://stackoverflow.com/questions/19798153/difference-between-map-applymap-and-apply-methods-in-pandas) between `apply`, `applymap` and `map` functions.  
  
[merging](http://pandas.pydata.org/pandas-docs/stable/merging.html) 
  
```python 
## script takes "unc*" files in a directory and spits out a file with matrix of expression data.  

import subprocess 
import pandas as pd 

p = subprocess.Popen('ls unc*', shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT) 
flag = 0 
 
for line in p.stdout.readlines(): 
 print line, 
 if not flag: 
  fullSet = pd.io.parsers.read_csv(line.strip(), sep = "\t") 
  fullSet = fullSet.rename(columns = {'normalized_count':line.strip()}) 
  flag = 1 
 else: 
  newSet = pd.io.parsers.read_csv(line.strip(), sep = "\t") 
  fullSet = pd.concat((fullSet, newSet['normalized_count']), axis = 1) 
  fullSet = fullSet.rename(columns = {'normalized_count':line.strip()}) 
 
fullSet.to_csv('fullSet.txt', sep = '\t', line_terminator = "\n", index = False) 
```

* date parsing can be done in pandas `read_csv`/`read_table` command. If done this way, we don't have to change the column to date time format later. 
