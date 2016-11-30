## Identifying Quality Variation in High Throughput Sequencing Datasets ##
### Brice J. Sarver ###

- mol variation
    - basis of disease
    - characterize pathways
    - association between G and P
    - systematic relationships
    - demographic patterns

- outline
    - fastq
    - sam
    - deduping, indel realignment
    - vcf
    - vcf filtering

- reads
- cleaned reads
    - remove low-quality bases
    - remove low-quality reads
    - remove residual adapters
    - remove duplicates
        - single end rnaseq data is generally not deduped 
    - merge overlaping reads
    - tools: trimmomatic, cuadapt, sickle, scythe, flash, superdeduper
- fastq format
```
@[IDENTIFIER][/1|/2]
ACGTACGTACGT
+
AAFAFGAA>>@B
```
- quality scores: per-position Phred-scaled [Q=-log(e)] base qualities in ASCII 
    - threshold generally 20-30
- mapping
    - reference by definition is haploid
    - BWA MEM, Bowtie, Bowtie2, TopHat
    - bowtie2 may involve param tuning
- sam format
    - header and alignment section
    - header fields start with @ and contain information about the reference seq, any grouping information and programs used to generate the SAM
    - post-mapping
        - remove unamapped reads
        - marking duplicate reads
        - indel identification and realignment
            - not required when calling haplotypes
- variant calling
    - genotypes are a function of the data available at a site and their quality
    - we need to explicitly account for erorr using statistics
    - confidence is assessed through the calculation of genotypic likelihoods (PL)
    - tools: gatk, freebayes, samtools
        - freebayes is not parallelizable
- VCF
    - header, meta-information, data
- variant filtering
    - variation -> good variation -> clinical variation
    - Broad has specific reco for human data, including additional steps using confident varaint sets
    - common filters
        - genotype quality
        - depth
        - allelic depth
        - hardy weinberg eq
        - missing data
        - variant confidence
