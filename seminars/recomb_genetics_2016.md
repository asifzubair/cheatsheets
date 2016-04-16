# RECOMB Genetics #

## Building catalog linking genes to the medical phenome ##
### Nancy Cox ###

- [PrediXcan](https://github.com/hakyim/PrediXcan): new approach to data integration
- [BioVU](https://victr.vanderbilt.edu/pub/biovu)
- [PheWAS](https://github.com/PheWAS/PheWAS) - package not related

## locLMM for heritability partitioning ##
### Lisa Gai ###

Accounting for linkage disequilibrium when estimating the contribution of a genomic region.
- heritability partitioning can give insights into:
  - genetic architectue
  - etc.
- LD leads to inflated heritability estimates. traditional methods ignore this

## Local joint testing improves power and identifies missing heritability in association studies. ##
### Brielin Brown ###

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
