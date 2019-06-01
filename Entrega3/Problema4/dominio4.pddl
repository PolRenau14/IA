(define (domain trobaviatges)
  (:requirements :strips :fluents)
  (:functions
    (visitades)
    (minim-preu)
    (maxim-preu)
    (minim-ciu)
    (minim-d-c)
    (minim-d)
    (maxim-d-c)
    (diastotal)
    (diesperciutat ?c - ciutat)
    (interes ?c - ciutat)
    (interestotal)
    (preuVol ?v - vol)
    (preuHotel ?h - hotel)
    (preutotal)
  )
  (:predicates 
    (en ?c - ciutat)
    (Vuelode ?v - vol ?c1 - ciutat ?c2 - ciutat)
    (Allotjamentde ?a - hotel ?c - ciutat)
    (Allotjaten ?c - ciutat)
    (AllotjatHotel ?h - hotel)
  )

(:action allotjar
  :parameters (?c - ciutat ?a - hotel)
  :precondition (and (en ?c)(Allotjamentde ?a ?c) (not(Allotjaten ?c)) )
  :effect (and
      (Allotjaten ?c)
      (AllotjatHotel ?a)
      )
    )


(:action assigna_dies_minims_a
  :parameters (?c - ciutat ?h - hotel)
  :precondition ( and (Allotjaten ?c) (AllotjatHotel ?h) (Allotjamentde ?h ?c) ( = (diesperciutat ?c) 0))
  :effect (and
	    (increase (diesperciutat ?c) (minim-d-c))
	    (increase (diastotal) (minim-d-c))
      	(increase (visitades) 1)
      	(increase (preutotal) (* (minim-d-c) (preuHotel ?h)))
        (increase (interestotal) (interes ?c))
    )
)

(:action assigna_un_dia
  :parameters (?c - ciutat ?h - hotel)
  :precondition (and (Allotjaten ?c)(AllotjatHotel ?h) (Allotjamentde ?h ?c)(< (diesperciutat ?c) (maxim-d-c)))
  :effect (and
	    (increase (diesperciutat ?c) 1)    
	    (increase (diastotal) 1)
	    (increase (preutotal) (preuHotel ?h))
    )
  )

(:action volar
  :parameters  (?c1 - ciutat ?c2 - ciutat ?v - vol)
  :precondition (and (en ?c1)(Vuelode ?v ?c1 ?c2))
  :effect (and
      (not(en ?c1))
      (en ?c2)
      (increase (preutotal) (preuVol ?v))
      )
    )
(:action volar
  :parameters  (?c2 - ciutat ?c1 - ciutat ?v - vol)
  :precondition (and (en ?c2)(Vuelode ?v ?c1 ?c2))
  :effect (and
      (not(en ?c2))
      (en ?c1)
      (increase (preutotal) (preuVol ?v))
      )
    )
)