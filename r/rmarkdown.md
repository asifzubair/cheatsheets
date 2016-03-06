# R markdown #

* R command line  
The R function `stitch_rmd` does something very similar to `File -> Compile Notebook`.

```
library(knitr) 
stitch_rmd('an-r-script.r')
```

* Shell command line
You can run R from the command line and call `knitr::stitch_rmd`.
```Rscript -e 'knitr::stitch_rmd("an-r-script.r")'```


##Installing Pandoc##

* Windows and Mac OS X
The pandoc installation page includes easy to use installers for Windows and Mac OS X.

* Linux 
The version of `pandoc` included in the standard repositories is **not** recent enough for use with the `rmarkdown` package. You can install a more recent version of pandoc by installing the Haskell Platform and then following these instructions for building `pandoc` from source. 
This method installs a large number of Haskell dependencies so might not be desirable. You can also obtain a standalone version of pandoc without the dependencies as follows: 

* Older Systems (RedHat/CentOS 5 & 6)  
For older Linux systems you can obtain a standalone version of `pandoc v1.12.3` (with no Haskell dependencies) from [here](http://petersen.fedorapeople.org/pandoc-standalone) as follows: 

```
$ sudo wget -P /etc/yum.repos.d/ http://petersen.fedorapeople.org/pandoc-standalone/pandoc-standalone.repo
$ yum install pandoc pandoc-citeproc
```

* Newer Systems (Debian/Ubuntu/Fedora) 

For newer Linux systems you can make a standalone version of `pandoc v1.12.3` available to the system by soft-linking the binaries included with `RStudio`: 
```
$ sudo ln -s /usr/lib/rstudio/bin/pandoc/pandoc /usr/local/bin 
$ sudo ln -s /usr/lib/rstudio/bin/pandoc/pandoc-citeproc /usr/local/bin 
``` 
If you are running RStudio Server the commands would be: 
```
$ sudo ln -s /usr/lib/rstudio-server/bin/pandoc/pandoc /usr/local/bin 
$ sudo ln -s /usr/lib/rstudio-server/bin/pandoc/pandoc-citeproc /usr/local/bin 
```
If you aren't running RStudio at all you can simply copy the binaries out of the RStudio `bin/pandoc` directory and locate them within `/usr/local/bin` on your target system. 

**What is a good way to convert R Markdown files to PDF documents?**
 
rmarkdown package 

**update (10 Feb 2013):** There is now an [rmarkdown package](https://github.com/rstudio/rmarkdown) available on github that interfaces with `pandoc`. It includes a render function. The documentation makes it pretty clear how to convert `rmarkdown` to `pdf` among a range of other formats. This includes including output formats in the `rmarkdown` file or running supplying an output format to the render function. E.g., 
```
render("input.Rmd", "pdf_document") 
``` 
Note: needs `curl/curl-config` to be installed beforehand - see [here](http://curl.haxx.se/docs/install.html) for installing from source. 


**Solution:** install `knitr` and `rmarkdown` in `R`, `pandoc` from `pandoc` folder in `Rstudio` installation and finally use the command line =>
```
Rscript -e 'rmarkdown::render("md_this.Rmd")'
```
