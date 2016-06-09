## Metagenomics Analysis ##

workflow 
```
trim low-quality regions -> 
    de-noising (Ampliconnoise, QIIME) ->
        OTU clustering (Algorithm: UCLUST; Tools: QIIME, MOthur) ->
            Taxonominc assinment of OTUs (Algorithm: BLAST; Tools: QIIME, Mothur ->
                Statistical analysis of visual results
```
shotgun metagenomics
```
Precprocessing: trimming -> Deduplicating -> Screening
Sequence reconstruction and grouping: Assembly -> binning 
Gene sequence prediction: rRNA, tRNA prediction [tRNAscon] -> gene calling [FragGeneScan]

Functional assignment to the predicted protein coding genes:
    Tools:  IMG/MER, MGRAST
    Databases: KEGG SEED, eggnog, COG/KOG, PFAM, TIGRFAM, Interpro
```
Tools:
- [Mothur](http://www.mothur.org)
- [QIIME](http://qiime.org)
