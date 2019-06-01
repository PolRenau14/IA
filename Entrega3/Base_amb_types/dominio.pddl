(define (domain trobaviatges)
  (:requirements :strips :typing :fluents)
(:functions
	(visitades)
  (minim-ciu)
)
(:predicates 
  (en ?c - ciutat)
  (Vuelode ?v - vol ?c1 - ciutat ?c2 - ciutat)
	(Allotjamentde ?a -hotel ?c - ciutat)
  (Allotjaten ?c - ciutat)
)


(:action allotjar
  :parameters (?c - ciutat ?a - hotel)
  :precondition (and (en ?c)(Allotjamentde ?a ?c) (not(Allotjaten ?c)) )
  :effect (and
    (Allotjaten ?c)
    (increase (visitades) 1)
    )
  )

(:action volar
  :parameters  (?c1 - ciutat ?c2 - ciutat ?v - vol)
  :precondition (and (en ?c1)(Vuelode ?v ?c1 ?c2))
  :effect (and
    (not(en ?c1))
    (en ?c2)
    )
  )
(:action volar
  :parameters  (?c2 - ciutat ?c1 - ciutat ?v - vol)
  :precondition (and (en ?c2)(Vuelode ?v ?c1 ?c2))
  :effect (and
    (not(en ?c2))
    (en ?c1)
    )
  )
)
