(define (domain trobaviatges)
  (:requirements :strips :fluents)
  (:functions
    (visitades)
    (minim-ciu)
    (minim-d-c)
    (minim-d)
    (maxim-d-c)
    (diastotal)
    (diesperciutat ?c - ciutat)
  )
  (:predicates 
    (Vol ?v - vol)
    (en ?c - ciutat)
    (Vuelode ?v - vol ?c1 - ciutat ?c2 - ciutat)
    (Allotjamentde ?a - hotel ?c - ciutat)
    (Allotjaten ?c - ciutat)
  )

  (:action allotjar
    :parameters (?c - ciutat ?a - hotel)
    :precondition (and (en ?c) (Allotjamentde ?a ?c) (not(Allotjaten ?c)) )
    :effect (and
      (Allotjaten ?c)
      )
    )


(:action assigna_dies_minims_a
  :parameters (?c - ciutat)
  :precondition ( and (Allotjaten ?c) (= (diesperciutat ?c) 0) )
  :effect (and
      (increase (diesperciutat ?c) (minim-d-c))
      (increase (diastotal) (minim-d-c))
      (increase (visitades) 1)
    )
)

(:action assigna_un_dia
  :parameters (?c - ciutat)
  :precondition (and (Allotjaten ?c)(< (diesperciutat ?c) (maxim-d-c)))
  :effect (and
    (increase (diesperciutat ?c) 1)    
    (increase (diastotal) 1)
    )
  )

  (:action volar
    :parameters  (?c1 - ciutat ?c2 - ciutat ?v - vol)
    :precondition (and (en ?c1)  (Vuelode ?v ?c1 ?c2))
    :effect (and
      (not(en ?c1))
      (en ?c2)
      )
    )

  (:action volar
    :parameters  (?c2 - ciutat ?c1 - ciutat ?v - vol)
    :precondition (and (en ?c2)  (Vuelode ?v ?c1 ?c2))
    :effect (and
      (not(en ?c2))
      (en ?c1)
      )
    )
)