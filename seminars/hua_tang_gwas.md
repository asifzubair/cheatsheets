## Learning about the Genetic Architecture Of Complex Traits Across Populations ##
### Hua Tang ###

- leveraging multi-ethnic evidence for mapping complex traits in minority populations
- trans-ethnic mapping approach

- GWAS
    - phenotype
    - genotype: 0,1,2
    - genome wide scan
        - tenting ~1M SNP markers
        - one marker a time
        - bonferrnoi corrrection: p < 5*10^-8
- lessons learned
    - many diseases feature highly polygenic genetic architecture
        - polygeneic genetic architecture of lipids: 
            - gwas in europeans, 
            - N  = 100K, n = 95, meta analysis
        - marginal effect is quite modest
            - statistical poer requires large cohort
        - minority populations the sample size is even smaller
            - downsampling european dataset eliminates the signal
    - disease susceptibility loci often overlap between ethnicities
        - [winner's curse](http://www.els.net/WileyCDA/ElsArticle/refId-a0022495.html)
- trans-ethnic mapping approach
    - rasonable to "borrow" inofrmation across populations
        - permit population-specifc loci
    - how much to borrow
        - similarity between populations
        - traits
            - skin pigmentation has undergone strong local adaptation
    - how to do in principled way 
        - use GWAS data to assess similarity between the two cohorts (wrt specific trait)
- model in one population
    - Sm - chi-squared statistic
    - test statistics from reference population as a mixture
    - locfdr: posterior
- borrowing information across ethnicity
    - X-population locfdr (XPEB)
    - qualitative description: decision boundary
        - negative slope in "EB rejection region"
        - no matter how strong the evidence in reference population we require evidence also in target population
        - can simulate the overlap of genetic architecture in target and reference populations

- EB paper, Hua Tang: AJHG

- Genetic Risk Assessment for Minority Populations
    - genetic Risk Scores
    - approaches 
        - dosage model: high risk alleles across all significant loci
        - polygeneic model (Yang et al, 2010)
    - standard polygenic model and prediction
        - linear mixed effects model
            - doesn't work very well
        - coram et al
    - trans-ethnic polygenic model and prediction
        - classify strong and weak loci
        - _strong loci_ selected from meta-analysis in europeans
        - allelic effects estimated using african american individuals
        
- [Comp. Precision Health](http://dahshu.org/events/cph2017)
