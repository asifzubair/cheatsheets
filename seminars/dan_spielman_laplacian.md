## Laplacian 
### Dan Spielman ###

- zhu, ghahramani lafferty '03
- spectral clustering an partitioning
    - heuristic to find x with small `x'Lx`
    - helps to find clusters
- Laplacian
    - xi - xj  = (1 -1) (xi xj)'
    - use this to rewrite (xi -xj)^2
- Weighted Laplacian = B'WB
- S,Teng '04 sole Laplacian equations
- koutis, miller, peng '11 - low-stretch trees and sampling 
- cohen, rao '14
code 
    - LAMG
    - CMG
- isotonic regression
    - isotonic functon, take a dag and assigns values to nodes such that they are always increasing
    - fast ipm for isotonic regression - kyng, rao, sachdeva '15
- solving laplcian equations by sparsifying
    - peng, s '14
    - sparsifying graphs
        - batson, srivastava '09
        - srivastava '08
- sparsified cholesky factorization 
    - kyng, lee, peng, sachdeva '15
    - kyng, sachdeva - arxive - '16
        - random sampling algorithm
- material
    - web page
    - lecture notes
    - nisheeth vishnoi - Lx = b
