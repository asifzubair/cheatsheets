# Bioconductor #

Preprocessing by RMA - this is for Affymetrix data 
 
Genetic information, such as single nucleotide polymorphisms, have a chance of being transmitted across generations. mRNA transcripts and proteins such as transcription factors degrade over time and, most importantly, do not replicate themselves. In other words, DNA (not proteins or RNA) is known as the main molecule of genetic inheritance. (Side note: There are cases of mRNA and proteins being temporarily inherited, for example the mRNA which are in the egg cell at the moment it is fertilized by the sperm cell.) 
 
GRanges 
 
**EDA**   
* use a log transformation to look at the histogram  
* use the density function  
	* `par(mfrow=c(1,1))`  

```
for (i in 1:ncol(int)) 
	if (i == 1) plot(density(log2(int[,i])), col = (i == 4) + 1) else lines(density(log2(int[,i])), col = (i == 4) + 1) 
```

* correlation plots, MA plots 
* scatter plot: take a random sample and do it 

```
splot<- function(x,y,…){ 
	ind<-sample(length(x),10000) 
	x=x[ind];y=y[ind] 
	plot(x,y,…) 
}
```

MA plot:`maplot<- function(x,y,…) splot((x+y)/2,y-x,…)`  

[EDA for NGS data](https://github.com/genomicsclass/labs/blob/master/course4/EDA_plots_for_NGS.Rmd)
