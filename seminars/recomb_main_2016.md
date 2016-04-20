# RECOMB 2016 #

## Accurate Recovery of Ribosome Positions Reveals Slow Translation of Wobble-Pairing Codons in Yeast ##
### Hao Wang ###

- ribosome profiling: takes snapshots of ribosomes during translation
    - higher pileup should show slower movements
- A-site inference
    - previously only heuristic methods used
    - Deblur produces sharper profiles

## Multitask matrix completion for learning protein interactions across diseases ##
### Meghana Kshirsagar ###

- combine information across datasets to learn ppi
- use multitask learning
- multicompletion problem for ppi
    - make some biological assumptions
        - shared and specific components
- non-convex problem, but can use __alternating minimizaton__ procedure
- [software](http://www.cs.cmu.edu/~mkshirsa/bsl_mtl)

## Enabling Privacy-Preserving GWAS in Heterogenous Human Populations ##
### Sean Simmons ###

- eigenstrat
- jhonson and shmatikov
- [software](https://github.com/seanken/PrivSTRAT)

## Efficient Privacy-Preserving Read Mapping Using Locality Sensitive Hashing and Secure Kmer Voting ##
### Victoria Popic and Serafim Batzoglou ###

- seed-and-extend on hybrid clouds (chen et al. 2012)
- tool: Balaur

## Synthetic long-read sequencing reveals intraspecies diversity in the human microbiome ##
### Volodymyr Kuleshov, Serafim Batzoglou ###

- synthetic long reads
- nanoscope

## Fast Bayesian Inference of Copy Number Variants using Hidden Markov Models with Wavelet Compression ##
### John Wiedenhoeft ###

- CNV detection problem
- HMM approach
    - latent CNV state varaible
- frequentist approach
    - MLE of parameters using Baum-Welch
    - likelihood is not convex
- Bayesian inference of state sequence
    - no feasible closed form of the integral
    - Forward-backward Gibbs sampling
- Compressed Forward-Backward Sampling
- this approach uses Harr-Wavelet compression technique
