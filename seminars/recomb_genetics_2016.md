# RECOMB Genetics 2016 #

## Building catalog linking genes to the medical phenome ##
### Nancy Cox ###

- [PrediXcan](https://github.com/hakyim/PrediXcan): new approach to data integration
- [BioVU](https://victr.vanderbilt.edu/pub/biovu)
- [PheWAS](https://github.com/PheWAS/PheWAS) - package not related

## locLMM for heritability partitioning ##
### Lisa Gai, Eleazar Eskin ###

Accounting for linkage disequilibrium when estimating the contribution of a genomic region.
- heritability partitioning can give insights into:
  - genetic architectue
  - etc.
- LD leads to inflated heritability estimates. traditional methods ignore this

## Local joint testing improves power and identifies missing heritability in association studies ##
### Brielin Brown, Lior Pachter ###

- hidden versus missing heritability
- h^2_gwas vs. h^2_chip vs. h^2_fam
- joint testing: instead of marginal tests, use joint test to examine a pair of SNPS 
  - two degree chi-squared test
- linking masking
- literture on joint testing
  - wood et al. hum mol gen 2011
  - yang et al. nat gen 2012
  - lee et al 2011
- [paper](http://biorxiv.org/content/biorxiv/early/2016/02/18/040089.full.pdf)
- [jester](https://github.com/brielin/Jester)
- [impute2](https://mathgen.stats.ox.ac.uk/impute/impute_v2.html)
- local joint testing of all pairs of variants within __200KB of the TSS__
- Q: what about trans factors - if working within a close window of TSS

## Inferring local genealogical tree topologies from haplotypes with presence of recombination ##
### Sajad Mirzaei ###

- [RENT](http://www.computer.org/csdl/trans/tb/2011/01/ttb2011010182-abs.html), Wu, 2011
- [RENTPlus](https://github.com/SajadMirzaei/RentPlus)
- [UPGMA](https://en.wikipedia.org/wiki/UPGMA)

## Enhanced methods for gene expression imputation from genetic variation data ##
### Nicholas Mancuso ###

- impute gene expression and then use gene associations for disease
- `SNP -> GE -> Disease` 
- various regularized methods like [BLUP](https://en.wikipedia.org/wiki/Best_linear_unbiased_prediction) etc
- ensemble learning of cis-regulated expression
- [gEUVADIS](http://www.geuvadis.org/web/geuvadis;jsessionid=6C3CEC4B93669043F5EF2E9F01641051) dataset analysed

##  Polygenic adaptation of human complex traits. ##
### Jonathan Pritchard ###

- selective sweeps
    - the hitch hiking effect of a favourable gene, JM Smith, 1974
    - sweep model in humans
    - selection on at least 5 genes inolved in lighter skin pigementation in non-Africans
- soft sweeps
    - Przeworski et al., 2005
    - adaptation to high altitude
    - Yi et al , Science, 2010; Huerta-Sanchez, Nature, 2014
- overall, few clear examples of strong sweeps in human genome
    - Coop et al.
- adaptive shifts may instead occur through __polygenic adaptation__
    - Pritchard et al., 2010
    - polygeneic adaptation can be extremely raid, but leaves very subtle signal
        - example height; weedon et al 20008
        - _tall_ alleles systematicallyhigher frequencies in Northern vs. Southern Europe
        - Turchin ... Hirshhorn 2012, Robinson ... Visscher 2015
- Singleton Density Score ([SDS](https://cehg.stanford.edu/events/evolgenome-yair-field-stanford-university-pritchard-lab)) for measuring recent changes in allele frequencies
    - SDS measures differences in tip length between allelic backgrounds
- Detect polygenic adaptation in the last 2000 years: trait-SDS

## Gene and network analysis of common variants reveals novel associations in multiple complex diseases. ##
### Priyanka Nakka ###

- lack of power in GWAS could be due to __genetic heterogencity__
- basically, how to combine p-values of variants within a gene
    - naive approach, use the min p-value of variants in a gene
    - biased by gene length
- PEGASUS: gene scores are not biased by gene length
- [HotNet2](http://compbio.cs.brown.edu/projects/hotnet2)

## Simultaneous modeling of disease status and clinical phenotypes to increase power in GWAS ##
### Michael Bilow, Eleazar Eskin ###

- bayesian multivariate technique
- data is binary; use liability threshold model; back to safe world of normality
- using __multiple phenotypes__ increase power

## Sensitive detection of chromatin-altering polymorphisms reveals autoimmune disease mechanisms ##
### Ricardo Del Rosario, Shyam Prabhakar ###

- >90% of GWAS SNPs are in non-coding regions
- H3K27ac marks active enhancers and promoters
- Genotype-Independent Signal Correlation and Imbalance (GSCI) Test

## MUSE: a Multi-locus Sampling-based Epistasis Algorithm for Quantitative Genetic Trait Prediction ##
### Dan He ###

- Epistasis models
    - exhaustive search
    - greed algorithms: consider only strong marginal effects
- select significant interactions without generating them
- MUSE
    - sampling based approach
    - contraint based sampling
    - other sampling techniques explored
        - encoding based sampling
        - iterative sampling

##  Improving imputation accuracy by inferring causal variants in genetic studies ##
### Yue Wu, Eleazar Eskin ###

- estimate underlying haplotypes via hidden Markov Models
- CAUSAL-Imp
