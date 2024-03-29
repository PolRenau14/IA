(define (problem viatges) (:domain trobaviatges)
(:objects
 C0 C1 C2 C3 C4 - ciutat
 A1-1 A1-2 A2-1 A2-2 A3-1 A3-2 A3-3 A4-1 A4-2 A4-3 - hotel
 V0-4 V1-2 V1-3 V2-0 V3-2 V3-4 V4-0 V4-1 V4-2 - vol
)

(:init
 (Allotjamentde A1-1 C1)
 (Allotjamentde A1-2 C1)
 (Allotjamentde A2-1 C2)
 (Allotjamentde A2-2 C2)
 (Allotjamentde A3-1 C3)
 (Allotjamentde A3-2 C3)
 (Allotjamentde A3-3 C3)
 (Allotjamentde A4-1 C4)
 (Allotjamentde A4-2 C4)
 (Allotjamentde A4-3 C4)
(Vuelode V0-4 C0 C4)
(Vuelode V1-2 C1 C2)
(Vuelode V1-3 C1 C3)
(Vuelode V2-0 C2 C0)
(Vuelode V3-2 C3 C2)
(Vuelode V3-4 C3 C4)
(Vuelode V4-0 C4 C0)
(Vuelode V4-1 C4 C1)
(Vuelode V4-2 C4 C2)
 (= (diesperciutat C1)0)
 (= (diesperciutat C2)0)
 (= (diesperciutat C3)0)
 (= (diesperciutat C4)0)
 (= (visitades) 0)
 (= (minim-ciu) 4)
 (= (minim-d-c) 1)
 (= (maxim-d-c) 5)
 (= (minim-d) 18)
 (= (diastotal) 0)
 (en C0)
)
 (:goal (and
  (>= (visitades) (minim-ciu))
  (>= (diastotal) (minim-d))
  (en C0)
)
)
)