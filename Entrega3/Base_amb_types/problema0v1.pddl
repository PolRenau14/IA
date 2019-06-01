(define (problem viatges) (:domain trobaviatges)
(:objects
 C0 C1 C2 C3 - ciutat
 A1-1 A1-2 A2-1 A3-1 - hotel
 V0-3 V0-1 V1-0 V2-0 V3-0 - vol
)

(:init
 (Allotjamentde A1-1 C1)
 (Allotjamentde A1-2 C1)
 (Allotjamentde A2-1 C2)
 (Allotjamentde A3-1 C3)
(Vuelode V0-3 C0 C3)
(Vuelode V0-1 C0 C1)
(Vuelode V1-0 C1 C0)
(Vuelode V2-0 C2 C0)
(Vuelode V3-0 C3 C0)
 (= (visitades) 0)
 (= (minim-ciu) 1)
 (en C0)
)
 (:goal (and
  (>= (visitades) (minim-ciu))
 (en C0)
)
)
)