## Happy Scientist: Build R Packages ##
### Patrick Muchmore ###

- [RPackageTemplate](https://github.com/patrickmuchmore/RPackageTemplate) 
- `.Rbuildignore`
  - files that we don't want R to work with. 
- don't want to sync with git files that can be automatically generated
  - only going to share inputs and not outputs
  - ex. manual pages are not included
- cpp folder
  - `Makevars`
- test folder
- code coverage, works with travis  

- cpp file
  - `Rcpp::compileAttributes()`
  - Rcpp let's you deal with CPP
  - RcppArmadillo calls LAPACK etc packages, it is header only
  - Rcpp lets you ahve access to the random number generator and math libraries that come with R
  
- file RPackageTemplate.R
  - package documentation
  - go into namespace
  
- roxygen
  - documentation along with code  

- may have to run valgrind before submitting to cran
