## ChIP-seq Data Analysis Using Galaxy ##
### Bing Li ###

- QC
  - PCr amplification and sequencing artifacts
  - Repeat regions affect read alignment
  - Chromatin structure affects sonifaction
  - Control sample is therefore very important

- Inferecne
  - Genome-wde binding profiles of target proteins (TFs, histone modifications)
  - Genes regulated by proteins
  - DNA binding motifs of target proteins
  - co-occupation of proteins on genome

- Flow
  - Sequencing reads : fastq
  - QC : QC report
  - preprocess data : fastqsanger files
  - reads alignment : sam files
  - data normalization and peak calling : bed, bedgraph, bigwig
  - downstream analysis (peak annotation, motif analysis) 

- [fastqgroomer](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC2894519)
- alignment - `flagstat`
  - if > 80% mapped reads - EXCELLENT
  - if > 60% mapped reads - GOOD
  - if < 30% reads aligned - FAILED
- [IGB](http://bioviz.org/igb/index.html)

- peak annotation & GO
  - [CEAS](http://liulab.dfci.harvard.edu/CEAS)
    - only takes bigwig and not bedgraph
  - [GREAT](http://bejerano.stanford.edu/great/public/html)
  - [DAVID](https://david.ncifcrf.gov)
- TF binding motif analysis
  - [SeqPos](https://testtoolshed.g2.bx.psu.edu/repository/display_tool?repository_id=2e2b965e6ae347f4&tool_config=database%2Fcommunity_files%2F001%2Frepo_1299%2Fseqpos.xml&changeset_revision=040fb4c886ae)
  - [MEME](http://meme-suite.org)
