## Statistical Methods to Understand the Genetic Architecture of Complex Traits ## 
### Farhad Hormozdiari ###

- sequencing
- association statistics
- privacy preserving

- can we detect the actual causal SNP ? 
- what is the biological process for these variants ? 
- How many causal variants harbor a locus ?
- can we imporve the results of gwas ? (for phenotypes that are hard to detect)

- top k SNPs method
    - ignores LD
    - how to pick k ?
- conditional method 
    - select the most significant snp based on p-values
    - re-compute the statistica scores conditional on selected SNP
- [CAVIAR](http://genetics.cs.ucla.edu/caviar) 
    - (CAusal Variants Identification in Associated Regions): causal variants from candidate SNPs

- computing likelihood
    - LD is correlation
- CAVIAR works off of summary statistics

- Caviar-Gene

- eQTL and GWAS colocalisation
- eCAVIAR

- intermediate phenotype (molecular phenotype)
    - [hormozdiari 2016 AJHG](http://www.cell.com/ajhg/comments/S0002-9297(16)30439-6)
    
- partition hertability 
- novel method to perform 'set' association testing
- [ernst et al nature biotech 2015](http://www.nature.com/nbt/journal/v28/n8/abs/nbt.1662.html)
