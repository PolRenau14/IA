
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

Cueing down from goal distance:   34 into depth [1]
                                  32            [1]
                                  28            [1]
                                  26            [1]
                                  24            [1]
                                  23            [1]
                                  20            [1]
                                  18            [1]
                                  17            [1]
                                  16            [1]
                                  15            [1]
                                  14            [1][2][3]
                                  13            [1][2]
                                  12            [1]
                                  11            [1]
                                  10            [1][2]
                                   9            [1]
                                   8            [1][2][3][4]
                                   7            [1][2][3][4]
                                   6            [1]
                                   5            [1][2][3][4]
                                   4            [1]
                                   3            [1][2][3][4][5][6]
                                   2            [1][2][3][4][5][6]
                                   1            [1]
                                   0            

ff: found legal plan as follows

step    0: VOLAR C0 C1 V1-0
        1: VOLAR C1 C2 V1-2
        2: VOLAR C2 C3 V3-2
        3: ALLOTJAR C3 A3-1
        4: VOLAR C3 C8 V8-3
        5: ALLOTJAR C8 A8-1
        6: VOLAR C8 C4 V4-8
        7: ALLOTJAR C4 A4-1
        8: VOLAR C4 C6 V6-4
        9: ALLOTJAR C6 A6-1
       10: VOLAR C6 C0 V0-6
       11: ASSIGNA_DIES_MINIMS_A C6
       12: ASSIGNA_UN_DIA C6
       13: ASSIGNA_UN_DIA C6
       14: VOLAR C0 C12 V0-12
       15: ALLOTJAR C12 A12-1
       16: VOLAR C12 C0 V0-12
       17: ASSIGNA_DIES_MINIMS_A C8
       18: ASSIGNA_UN_DIA C8
       19: ASSIGNA_UN_DIA C8
       20: ASSIGNA_UN_DIA C8
       21: ASSIGNA_DIES_MINIMS_A C3
       22: VOLAR C0 C9 V9-0
       23: ALLOTJAR C9 A9-1
       24: VOLAR C9 C0 V9-0
       25: ASSIGNA_DIES_MINIMS_A C12
       26: VOLAR C0 C10 V10-0
       27: ALLOTJAR C10 A10-1
       28: VOLAR C10 C0 V10-0
       29: ASSIGNA_DIES_MINIMS_A C10
       30: ASSIGNA_DIES_MINIMS_A C9
       31: VOLAR C0 C1 V1-0
       32: ALLOTJAR C1 A1-1
       33: VOLAR C1 C0 V1-0
       34: ASSIGNA_DIES_MINIMS_A C4
       35: ASSIGNA_DIES_MINIMS_A C1
       36: VOLAR C0 C10 V10-0
       37: VOLAR C10 C11 V11-10
       38: ALLOTJAR C11 A11-1
       39: VOLAR C11 C9 V9-11
       40: VOLAR C9 C0 V9-0
       41: ASSIGNA_DIES_MINIMS_A C11
       42: VOLAR C0 C9 V9-0
       43: VOLAR C9 C13 V13-9
       44: ALLOTJAR C13 A13-1
       45: VOLAR C13 C9 V13-9
       46: VOLAR C9 C0 V9-0
       47: ASSIGNA_DIES_MINIMS_A C13
     

time spent:    0.00 seconds instantiating 104 easy, 0 hard action templates
               0.00 seconds reachability analysis, yielding 41 facts and 102 actions
               0.00 seconds creating final representation with 40 relevant facts, 29 relevant fluents
               0.00 seconds computing LNF
               0.00 seconds building connectivity graph
               0.00 seconds searching, evaluating 348 states, to a max depth of 6
               0.00 seconds total time

