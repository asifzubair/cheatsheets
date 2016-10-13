## Quantitation in Colocalization Analysis: Beyond "Red + Green = Yellow" ##
### Ming Yuan ###

- [imagej](https://imagej.nih.gov/ij)
- quanitating the cell - _upcoming review_
- colocalization analysis
    - multichannel lfluorescnece imaging
    - to understand complex interactions between biological molecules
- red + green = yellow
    - used to study colocalization
    - subjective
    - susceptible to cross-talk, relative intensities etc.
- coefficients of colocalization
    - pearson's corr coeff.
    - mander's colocalization coeff.
        - subjective
        - coeff. is not statistically significant
- structured correlation detection
    - assume (X_i, Y_i) follows bivariate normal distribution
- scan statistic
    - liklihood ratio statistic
    - scan/generalized likelhood ratio
    - limitations
        - conservative for large regions
        - computationally expensive
