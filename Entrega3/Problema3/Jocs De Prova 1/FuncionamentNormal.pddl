
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

Cueing down from goal distance:    8 into depth [1][2]
                                   6            [1]
                                   4            [1][2]
                                   3            [1] --- pruning stopped --- [1]

Enforced Hill-climbing failed !
switching to Best-first Search now.


advancing to distance:    8
                          6
                          4
                          3
                          2
                          1
                          0

ff: found legal plan as follows

step    0: VOLAR C0 C7 V0-7
        1: ALLOTJAR C7 A7-1
        2: VOLAR C7 C0 V0-7
        3: ASSIGNA_DIES_MINIMS_A C7 A7-1
        4: ASSIGNA_UN_DIA C7 A7-1
        5: ASSIGNA_UN_DIA C7 A7-1
        6: ASSIGNA_UN_DIA C7 A7-1
        7: ASSIGNA_UN_DIA C7 A7-1
     

time spent:    0.00 seconds instantiating 94 easy, 0 hard action templates
               0.00 seconds reachability analysis, yielding 49 facts and 94 actions
               0.00 seconds creating final representation with 48 relevant facts, 22 relevant fluents
               0.00 seconds computing LNF
               0.00 seconds building connectivity graph
               0.03 seconds searching, evaluating 1221 states, to a max depth of 2
               0.03 seconds total time

