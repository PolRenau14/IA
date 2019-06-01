
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

Cueing down from goal distance:   14 into depth [1]
                                  13            [1][2]
                                  12            [1][2]
                                  11            [1][2]
                                  10            [1][2][3]
                                   9            [1][2][3]
                                   7            [1][2][3][4][5]
                                   6            [1][2][3][4]
                                   5            [1][2]
                                   4            [1][2]
                                   3            [1]
                                   2            [1]
                                   1            [1]
                                   0            

ff: found legal plan as follows

step    0: VOLAR C0 C7 V0-7
        1: ALLOTJAR C7 A7-1
        2: VOLAR C7 C6 V7-6
        3: ALLOTJAR C6 A6-1
        4: VOLAR C6 C4 V4-6
        5: VOLAR C4 C0 V4-0
        6: VOLAR C0 C1 V1-0
        7: ALLOTJAR C1 A1-1
        8: VOLAR C1 C0 V1-0
        9: VOLAR C0 C4 V4-0
       10: VOLAR C4 C10 V4-10
       11: ALLOTJAR C10 A10-1
       12: VOLAR C10 C4 V4-10
       13: ALLOTJAR C4 A4-1
       14: VOLAR C4 C10 V4-10
       15: VOLAR C10 C9 V10-9
       16: ALLOTJAR C9 A9-1
       17: VOLAR C9 C2 V9-2
       18: ALLOTJAR C2 A2-1
       19: VOLAR C2 C5 V2-5
       20: ALLOTJAR C5 A5-1
       21: VOLAR C5 C3 V3-5
       22: ALLOTJAR C3 A3-1
       23: VOLAR C3 C10 V10-3
       24: VOLAR C10 C8 V8-10
       25: ALLOTJAR C8 A8-1
       26: VOLAR C8 C10 V8-10
       27: VOLAR C10 C4 V4-10
       28: VOLAR C4 C0 V4-0
     

time spent:    0.00 seconds instantiating 59 easy, 0 hard action templates
               0.00 seconds reachability analysis, yielding 32 facts and 59 actions
               0.00 seconds creating final representation with 31 relevant facts, 1 relevant fluents
               0.00 seconds computing LNF
               0.00 seconds building connectivity graph
               0.00 seconds searching, evaluating 105 states, to a max depth of 5
               0.00 seconds total time

