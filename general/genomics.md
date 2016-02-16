# Genomics #

* [GGD](http://www.gettinggeneticsdone.com/2012/04/awk-command-to-count-total-unique-and.html): Useful `awk` script.  

```
gzip -d -c myfile.fq.gz | awk '((NR-2)%4==0){read=$1;total++;count[read]++}END{for(read in count)\
{if(!max||count[read]>max){max=count[read];maxRead=read};if(count[read]==1){unique++}}; \
print total,unique,unique*100/total,maxRead,count[maxRead],count[maxRead]*100/total}'
```
The output would look something like this for RNA-seq data:  
`99115 60567 61.1078 ACCTCAGGA 354 0.357161`

This is telling you:  
* The total number of reads (99,115).  
* The number of unique reads (60,567).  
* The frequency of unique reads as a proportion of the total (61%).  
* The most abundant sequence (useful for finding adapters, linkers, etc).  
* The number of times that sequence is present (354).  
* The frequency of that sequence as a proportion of the total number of reads (0.35%).
   

* GGD: Useful [oneliners](https://github.com/stephenturner/oneliners)  

---

## Bioconductor ##

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

---

**References:**  
GGD: http://www.gettinggeneticsdone.com

**Bioinformatics**
* https://wikis.utexas.edu/display/bioiteam/SSC+Intro+to+NGS+Bioinformatics+Course
* http://www.personal.psu.edu/iua1/2015_fall_852/main_2015_fall_852.html
