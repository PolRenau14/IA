(define (domain trobaviatges)
  (:requirements :strips :fluents)
(:functions
	(visitades)
  (minim-ciu)
)
(:predicates (Ciutat ?c)
             (Allotjament ?a)
             (Vol ?x)
             (en ?c)
             (Vuelode ?v ?c1 ?c2)
	     (Allotjamentde ?a ?c)
       (Allotjaten ?c)
)

(:action allotjar
  :parameters (?c ?a)
  :precondition (and (en ?c) (Ciutat ?c) (Allotjament ?a) (Allotjamentde ?a ?c) (not(Allotjaten ?c)) )
  :effect (and
    (Allotjaten ?c)
    (increase (visitades) 1)
    )
  )

(:action volar
  :parameters  (?c1 ?c2 ?v)
  :precondition (and (en ?c1) (Ciutat ?c1) (Ciutat ?c2) (Vol ?v) (Vuelode ?v ?c1 ?c2))
  :effect (and
    (not(en ?c1))
    (en ?c2)
    )
  )
)