(define (problem viatges) (:domain trobaviatges)
(:objects
 C0 C1 C2 C3 C4 C5 C6 C7 C8 C9 C10 - ciutat
 A1-1 A1-2 A1-3 A2-1 A2-2 A3-1 A3-2 A3-3 A4-1 A4-2 A4-3 A5-1 A5-2 A6-1 A6-2 A6-3 A7-1 A7-2 A8-1 A8-2 A8-3 A9-1 A9-2 A9-3 A10-1 - hotel
 V0-7 V1-0 V2-5 V2-1 V2-10 V3-5 V3-6 V4-0 V4-6 V4-10 V5-10 V6-7 V7-6 V8-10 V9-2 V10-3 V10-9 - vol
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
 (Allotjamentde A5-2 C5)
 (Allotjamentde A6-1 C6)
 (Allotjamentde A6-2 C6)
 (Allotjamentde A6-3 C6)
 (Allotjamentde A7-1 C7)
 (Allotjamentde A7-2 C7)
 (Allotjamentde A8-1 C8)
 (Allotjamentde A8-2 C8)
 (Allotjamentde A8-3 C8)
 (Allotjamentde A9-1 C9)
 (Allotjamentde A9-2 C9)
 (Allotjamentde A9-3 C9)
 (Allotjamentde A10-1 C10)
(Vuelode V0-7 C0 C7)
(Vuelode V1-0 C1 C0)
(Vuelode V2-5 C2 C5)
(Vuelode V2-1 C2 C1)
(Vuelode V2-10 C2 C10)
(Vuelode V3-5 C3 C5)
(Vuelode V3-6 C3 C6)
(Vuelode V4-0 C4 C0)
(Vuelode V4-6 C4 C6)
(Vuelode V4-10 C4 C10)
(Vuelode V5-10 C5 C10)
(Vuelode V6-7 C6 C7)
(Vuelode V7-6 C7 C6)
(Vuelode V8-10 C8 C10)
(Vuelode V9-2 C9 C2)
(Vuelode V10-3 C10 C3)
(Vuelode V10-9 C10 C9)
 (= (visitades) 0)
 (= (minim-ciu) 10)
 (en C0)
)
 (:goal (and
  (>= (visitades) (minim-ciu))
 (en C0)
)
)
)
