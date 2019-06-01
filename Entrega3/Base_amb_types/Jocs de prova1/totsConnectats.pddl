
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

Cueing down from goal distance:    3 into depth [1][2][3]
                                   2            [1]
                                   1            [1]
                                   0            

ff: found legal plan as follows

step    0: VOLAR C0 C2 V2-0
        1: ALLOTJAR C2 A2-1
        2: VOLAR C2 C5 V5-2
        3: ALLOTJAR C5 A5-1
        4: VOLAR C5 C0 V0-5
     

time spent:    0.00 seconds instantiating 30 easy, 0 hard action templates
               0.00 seconds reachability analysis, yielding 17 facts and 30 actions
               0.00 seconds creating final representation with 16 relevant facts, 1 relevant fluents
               0.00 seconds computing LNF
               0.00 seconds building connectivity graph
               0.00 seconds searching, evaluating 7 states, to a max depth of 3
               0.00 seconds total time

