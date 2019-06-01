
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

Cueing down from goal distance:   43 into depth [1]
                                  38            [1]
                                  33            [1]
                                  32            [1]
                                  31            [1][2]
                                  30            [1]
                                  29            [1]
                                  28            [1]
                                  25            [1]
                                  24            [1][2]
                                  23            [1]
                                  22            [1]
                                  21            [1]
                                  20            [1]
                                  19            [1]
                                  18            [1][2]
                                  16            [1][2]
                                  15            [1]
                                  14            [1][2][3][4]
                                  13            [1][2]
                                  12            [1]
                                  11            [1]
                                  10            [1]
                                   9            [1][2]
                                   8            [1][2][3]
                                   7            [1][2]
                                   6            [1]
                                   5            [1]
                                   4            [1]
                                   3            [1][2][3][4]
                                   2            [1][2][3][4]
                                   1            [1]
                                   0            

ff: found legal plan as follows

step    0: VOLAR C0 C1 V1-0
        1: VOLAR C1 C6 V6-1
        2: ALLOTJAR C6 A6-1
        3: ASSIGNA_DIES_MINIMS_A C6
        4: VOLAR C6 C1 V6-1
        5: ALLOTJAR C1 A1-1
        6: VOLAR C1 C13 V1-13
        7: VOLAR C13 C4 V13-4
        8: ALLOTJAR C4 A4-1
        9: ASSIGNA_UN_DIA C6
       10: VOLAR C4 C7 V4-7
       11: ALLOTJAR C7 A7-1
       12: ASSIGNA_UN_DIA C6
       13: VOLAR C7 C10 V7-10
       14: ALLOTJAR C10 A10-1
       15: ASSIGNA_UN_DIA C6
       16: ASSIGNA_DIES_MINIMS_A C7
       17: VOLAR C10 C11 V11-10
       18: VOLAR C11 C0 V11-0
       19: ASSIGNA_UN_DIA C7
       20: ASSIGNA_UN_DIA C7
       21: ASSIGNA_UN_DIA C7
       22: ASSIGNA_DIES_MINIMS_A C4
       23: ASSIGNA_UN_DIA C4
       24: ASSIGNA_UN_DIA C4
       25: ASSIGNA_UN_DIA C4
       26: VOLAR C0 C11 V11-0
       27: ALLOTJAR C11 A11-1
       28: VOLAR C11 C0 V11-0
       29: ASSIGNA_DIES_MINIMS_A C11
       30: ASSIGNA_UN_DIA C11
       31: ASSIGNA_UN_DIA C11
       32: ASSIGNA_UN_DIA C11
       33: ASSIGNA_DIES_MINIMS_A C1
       34: ASSIGNA_UN_DIA C1
       35: ASSIGNA_UN_DIA C1
       36: VOLAR C0 C8 V0-8
       37: ALLOTJAR C8 A8-1
       38: VOLAR C8 C0 V0-8
       39: ASSIGNA_DIES_MINIMS_A C10
       40: ASSIGNA_UN_DIA C10
       41: ASSIGNA_DIES_MINIMS_A C8
       42: VOLAR C0 C2 V2-0
       43: ALLOTJAR C2 A2-1
       44: VOLAR C2 C0 V2-0
       45: ASSIGNA_DIES_MINIMS_A C2
       46: VOLAR C0 C3 V0-3
       47: ALLOTJAR C3 A3-1
       48: VOLAR C3 C0 V0-3
       49: ASSIGNA_DIES_MINIMS_A C3
     

time spent:    0.00 seconds instantiating 115 easy, 0 hard action templates
               0.00 seconds reachability analysis, yielding 44 facts and 113 actions
               0.00 seconds creating final representation with 43 relevant facts, 30 relevant fluents
               0.00 seconds computing LNF
               0.00 seconds building connectivity graph
               0.00 seconds searching, evaluating 577 states, to a max depth of 4
               0.00 seconds total time

