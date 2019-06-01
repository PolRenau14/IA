(define (problem viatges) (:domain trobaviatges)
(:objects
 C0 C1 C2 C3 C4 C5 - ciutat
 A1-1 A1-2 A1-3 A2-1 A2-2 A3-1 A3-2 A3-3 A4-1 A4-2 A4-3 A5-1 - hotel
 V0-5 V0-3 V1-4 V2-0 V3-4 V4-3 V4-0 V5-1 V5-2 - vol
)

(:init
 (Allotjamentde A1-1 C1)
 (Allotjamentde A1-2 C1)
 (Allotjamentde A1-3 C1)
 (Allotjamentde A2-1 C2)
 (Allotjamentde A2-2 C2)
 (Allotjamentde A3-1 C3)
 (Allotjamentde A3-2 C3)
 (Allotjamentde A3-3 C3)
 (Allotjamentde A4-1 C4)
 (Allotjamentde A4-2 C4)
 (Allotjamentde A4-3 C4)
 (Allotjamentde A5-1 C5)
(Vuelode V0-5 C0 C5)
(Vuelode V0-3 C0 C3)
(Vuelode V1-4 C1 C4)
(Vuelode V2-0 C2 C0)
(Vuelode V3-4 C3 C4)
(Vuelode V4-3 C4 C3)
(Vuelode V4-0 C4 C0)
(Vuelode V5-1 C5 C1)
(Vuelode V5-2 C5 C2)
 (= (visitades) 0)
 (= (minim-ciu) 2)
 (en C0)
)
 (:goal (and
  (>= (visitades) (minim-ciu))
 (en C0)
)
)
)
