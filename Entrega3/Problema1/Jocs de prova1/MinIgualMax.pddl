
ff: parsing domain file
domain 'TROBAVIATGES' defined
 ... done.
ff: parsing problem file
problem 'VIATGES' defined
 ... done.


no metric specified. plan length assumed.

checking for cyclic := effects --- OK.

ff: search configuration is EHC, if that fails then  best-first on 1*g(s) + 5*h(s) where
    metric is  plan length

Cueing down from goal distance:    6 into depth [1]
                                   4            [1]
                                   3            [1]
                                   2            [1][2][3][4]
                                   1            [1]
                                   0            

ff: found legal plan as follows

step    0: VOLAR C0 C7 V7-0
        1: ALLOTJAR C7 A7-1
        2: VOLAR C7 C0 V7-0
        3: ASSIGNA_DIES_MINIMS_A C7
        4: VOLAR C0 C6 V0-6
        5: ALLOTJAR C6 A6-1
        6: VOLAR C6 C0 V0-6
        7: ASSIGNA_DIES_MINIMS_A C6
     

time spent:    0.00 seconds instantiating 63 easy, 0 hard action templates
               0.00 seconds reachability analysis, yielding 23 facts and 61 actions
               0.00 seconds creating final representation with 22 relevant facts, 16 relevant fluents
               0.00 seconds computing LNF
               0.00 seconds building connectivity graph
               0.00 seconds searching, evaluating 18 states, to a max depth of 4
               0.00 seconds total time

