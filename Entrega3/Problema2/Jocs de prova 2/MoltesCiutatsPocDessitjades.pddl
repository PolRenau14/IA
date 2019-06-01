	
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

Cueing down from goal distance:   16 into depth [1][2]
                                  15            [1]
                                  13            [1]
                                  12            [1]
                                   9            [1]
                                   8            [1]
                                   7            [1]
                                   6            [1][2]
                                   5            [1]
                                   4            [1][2][3]
                                   3            [1][2]
                                   2            [1]
                                   1            [1]
                                   0            

ff: found legal plan as follows

step    0: VOLAR C0 C3 V3-0
        1: ALLOTJAR C3 A3-1
        2: VOLAR C3 C8 V8-3
        3: VOLAR C8 C9 V8-9
        4: ALLOTJAR C9 A9-1
        5: VOLAR C9 C0 V9-0
        6: ASSIGNA_UN_DIA C9
        7: ASSIGNA_UN_DIA C9
        8: ASSIGNA_UN_DIA C9
        9: ASSIGNA_UN_DIA C9
       10: ASSIGNA_UN_DIA C9
       11: ASSIGNA_DIES_MINIMS_A C3
       12: ASSIGNA_UN_DIA C3
       13: ASSIGNA_UN_DIA C3
       14: VOLAR C0 C6 V6-0
       15: ALLOTJAR C6 A6-1
       16: VOLAR C6 C0 V6-0
       17: ASSIGNA_DIES_MINIMS_A C6
     

time spent:    0.00 seconds instantiating 81 easy, 0 hard action templates
               0.00 seconds reachability analysis, yielding 29 facts and 79 actions
               0.00 seconds creating final representation with 28 relevant facts, 21 relevant fluents
               0.00 seconds computing LNF
               0.00 seconds building connectivity graph
               0.00 seconds searching, evaluating 43 states, to a max depth of 3
               0.00 seconds total time

