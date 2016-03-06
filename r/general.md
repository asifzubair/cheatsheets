# General #

## Installation ##

Cran's R installation [guide](https://cran.r-project.org/bin/linux/ubuntu/README) on ubuntu

[Run R script from command line](http://stackoverflow.com/questions/18306362/run-r-script-from-command-line) 

If you want the output to print to the terminal it is best to use Rscript `Rscript a.R`  

Note that when using `R CMD BATCH a.R` that instead of redirecting output to `stdout` and displaying on the terminal a new file called `a.Rout` will be created.

```R CMD BATCH a.R # Check the output cat a.Rout```

If you really want to use the `./a.R` way of calling the script you could add an appropriate `#!` to the top of the script

```R
#!/usr/bin/env Rscript 
sayHello <- function(){ 
				print('hello') 
			}
sayHello()
```

You need the `Rscript` command to run an R script from the terminal.
Check out this [link](http://stat.ethz.ch/R-manual/R-devel/library/utils/html/Rscript.html)  

Example
```R
## example 
#! script for a Unix-alike
#! /path/to/Rscript --vanilla --default-packages=utils 
args <- commandArgs(TRUE)
res <- try(install.packages(args))
if(inherits(res, "try-error")) 
	q(status=1)
else
	q()
```
## Style Guide ##

- http://google-styleguide.googlecode.com/svn/trunk/Rguide.xml

## Tips/Tricks ##

- [1L vs. 1](http://stackoverflow.com/questions/7014387/whats-the-difference-between-1l-and-1)
