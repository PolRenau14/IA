(define (problem viatges) (:domain trobaviatges)
(:objects
 C0 C1 C2 C3 C4 C5 C6 C7 C8 C9 C10 C11 C12 C13 C14 - ciutat
 A1-1 A1-2 A2-1 A3-1 A3-2 A4-1 A4-2 A5-1 A5-2 A6-1 A7-1 A8-1 A8-2 A9-1 A10-1 A10-2 A10-3 A11-1 A11-2 A11-3 A12-1 A13-1 A14-1 A14-2 A14-3 - hotel
 V0-8 V0-3 V0-7 V1-13 V1-0 V2-8 V2-0 V3-10 V3-7 V3-8 V4-0 V4-7 V5-3 V6-1 V6-12 V6-14 V7-10 V8-1 V9-10 V9-3 V10-9 V11-0 V11-10 V11-2 V12-1 V13-11 V13-4 V13-5 V14-8 V14-6 - vol
)

(:init
 (Allotjamentde A1-1 C1)
 (Allotjamentde A1-2 C1)
 (Allotjamentde A2-1 C2)
 (Allotjamentde A3-1 C3)
 (Allotjamentde A3-2 C3)
 (Allotjamentde A4-1 C4)
 (Allotjamentde A4-2 C4)
 (Allotjamentde A5-1 C5)
 (Allotjamentde A5-2 C5)
 (Allotjamentde A6-1 C6)
 (Allotjamentde A7-1 C7)
 (Allotjamentde A8-1 C8)
 (Allotjamentde A8-2 C8)
 (Allotjamentde A9-1 C9)
 (Allotjamentde A10-1 C10)
 (Allotjamentde A10-2 C10)
 (Allotjamentde A10-3 C10)
 (Allotjamentde A11-1 C11)
 (Allotjamentde A11-2 C11)
 (Allotjamentde A11-3 C11)
 (Allotjamentde A12-1 C12)
 (Allotjamentde A13-1 C13)
 (Allotjamentde A14-1 C14)
 (Allotjamentde A14-2 C14)
 (Allotjamentde A14-3 C14)
(Vuelode V0-8 C0 C8)
(Vuelode V0-3 C0 C3)
(Vuelode V0-7 C0 C7)
(Vuelode V1-13 C1 C13)
(Vuelode V1-0 C1 C0)
(Vuelode V2-8 C2 C8)
(Vuelode V2-0 C2 C0)
(Vuelode V3-10 C3 C10)
(Vuelode V3-7 C3 C7)
(Vuelode V3-8 C3 C8)
(Vuelode V4-0 C4 C0)
(Vuelode V4-7 C4 C7)
(Vuelode V5-3 C5 C3)
(Vuelode V6-1 C6 C1)
(Vuelode V6-12 C6 C12)
(Vuelode V6-14 C6 C14)
(Vuelode V7-10 C7 C10)
(Vuelode V8-1 C8 C1)
(Vuelode V9-10 C9 C10)
(Vuelode V9-3 C9 C3)
(Vuelode V10-9 C10 C9)
(Vuelode V11-0 C11 C0)
(Vuelode V11-10 C11 C10)
(Vuelode V11-2 C11 C2)
(Vuelode V12-1 C12 C1)
(Vuelode V13-11 C13 C11)
(Vuelode V13-4 C13 C4)
(Vuelode V13-5 C13 C5)
(Vuelode V14-8 C14 C8)
(Vuelode V14-6 C14 C6)
 (= (diesperciutat C1)0)
 (= (diesperciutat C2)0)
 (= (diesperciutat C3)0)
 (= (diesperciutat C4)0)
 (= (diesperciutat C5)0)
 (= (diesperciutat C6)0)
 (= (diesperciutat C7)0)
 (= (diesperciutat C8)0)
 (= (diesperciutat C9)0)
 (= (diesperciutat C10)0)
 (= (diesperciutat C11)0)
 (= (diesperciutat C12)0)
 (= (diesperciutat C13)0)
 (= (diesperciutat C14)0)
 (= (visitades) 0)
 (= (minim-ciu) 9)
 (= (minim-d-c) 1)
 (= (maxim-d-c) 4)
 (= (minim-d) 21)
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