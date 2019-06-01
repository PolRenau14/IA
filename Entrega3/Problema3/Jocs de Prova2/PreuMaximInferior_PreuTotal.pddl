
ff: parsing domain file
domain 'TROBAVIATGES' defined
 ... done.
ff: parsing problem file
problem 'VIATGES' defined
 ... done.



no optimization required. skipping criterion.


no metric specified. plan length assumed.

checking for cyclic := effects --- OK.

ff: search configuration is EHC, if that fails then  best-first on 1*g(s) + 5*h(s) where
    metric is  plan length

Cueing down from goal distance:   51 into depth [1][2][3]
                                  49            [1][2][3][4][5]
                                  48            [1]
                                  47            [1][2][3] --- pruning stopped --- [1][2][3]

Enforced Hill-climbing failed !
switching to Best-first Search now.


advancing to distance:   51
                         49
                         48
                         47
                         45
                         43

best first search space empty! problem proven unsolvable.



time spent:    0.00 seconds instantiating 94 easy, 0 hard action templates
               0.00 seconds reachability analysis, yielding 49 facts and 94 actions
               0.00 seconds creating final representation with 48 relevant facts, 22 relevant fluents
               0.00 seconds computing LNF
               0.00 seconds building connectivity graph
               0.63 seconds searching, evaluating 26693 states, to a max depth of 5
               0.63 seconds total time

