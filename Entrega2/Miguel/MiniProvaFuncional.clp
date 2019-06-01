; Fri May 11 18:28:00 CEST 2018
; 
;+ (version "3.4.1")
;+ (build "Build 537")

(defclass %3ACLIPS_TOP_LEVEL_SLOT_CLASS "Fake class to save top-level slot information"
	(is-a USER)
	(role abstract)
	(single-slot Preu
		(type INTEGER)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot Tipus
		(type SYMBOL)
		(allowed-values Negocis Romantic Festa Cultural)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot Nom
		(type STRING)
;+		(cardinality 1 1)
		(create-accessor read-write)))

(defclass Viatge
	(is-a USER)
	(role concrete)
	(single-slot Preu
		(type INTEGER)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot Tipus
		(type SYMBOL)
		(allowed-values Negocis Romantic Festa Cultural)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot Nom
		(type STRING)
;+		(cardinality 1 1)
		(create-accessor read-write)))

(definstances Viatge
([KB_926295_Class5] of  Viatge

	(Nom "Barcelona")
	(Preu 150)
	(Tipus Cultural))

([KB_926295_Class6] of  Viatge

	(Nom "Mallorca")
	(Preu 500)
	(Tipus Festa))

([KB_926295_Class7] of  Viatge

	(Nom "Londres")
	(Preu 800)
	(Tipus Negocis)))


;;****************
;;* DEFFUNCTIONS *
;;****************

(deffunction ask-question (?question $?allowed-values)
   (printout t ?question)
   (bind ?answer (read))
   (if (lexemep ?answer) 
       then (bind ?answer (lowcase ?answer)))
   (while (not (member$ ?answer ?allowed-values)) do
      (printout t ?question)
      (bind ?answer (read))
      (if (lexemep ?answer) 
          then (bind ?answer (lowcase ?answer))))
   ?answer)

(deffunction yes-or-no-p (?question)
   (bind ?response (ask-question ?question yes no y n))
   (if (or (eq ?response yes) (eq ?response y))
       then TRUE 
       else FALSE))


(deffunction imprime-tot (?v)  
  (if (> (length$ ?v) 0) then
   (loop-for-count (?i 1 (length ?v))
     (send (nth$ ?i ?v) print)
	 (printout t crlf)	 
   )
 )
)

;;;**************************************************************
;;;* CREACIÓ INSTANCIES MANUALMENT (la trampilla que us he dit) *
;;;**************************************************************

;;; Creamos la instancia sobre la que trabajaremos
(defrule crea-instancia-inicial
 (declare (salience 10))
 =>
 (make-instance v1 of Viatge (Nom "Barcelona")(Preu 150)(Tipus Cultural)) 
 (make-instance v2 of Viatge (Nom "Mallorca")(Preu 500)(Tipus Festa))
 (make-instance v3 of Viatge (Nom "Londres")(Preu 800)(Tipus Negocis)) 
 )

;;;*********************
;;;* REGLES DE CONSULTA*
;;;*********************

(defrule determina-presupost "Preguntem sobre el presupost"
  (not(presupost ?))
  =>
  (printout t "Quin es el presupost per persona per a tot el viatge?" crlf "(baix(50-300) / mitja(301-700) / alt(+700))")
  (bind ?pres (read))
  (if (or (eq ?pres baix)(eq ?pres mitja)(eq ?pres alt))
    then (assert(presupost ?pres))
  )  
)

;;;****************************
;;;* REGLES DETERMINAR VIATGE *
;;;****************************


(defrule preu-viatge-alt
 (presupost alt)
 =>  
  (imprime-tot (find-instance ((?ins Viatge)) (> ?ins:Preu 700)))
)

(defrule preu-viatge-mitja
 (presupost mitja)
 =>  
  (imprime-tot (find-instance ((?ins Viatge))
  					 (and (<= ?ins:Preu 700) (> ?ins:Preu 300 ))))
)

(defrule preu-viatge-baix
 (presupost baix)
 =>    
  (imprime-tot (find-instance ((?ins Viatge))
  					 (and (< ?ins:Preu 300) (> ?ins:Preu 50 ))))
)


;;;*****************
;;;* ALTRES REGLES *
;;;*****************



;;;******************************
;;;* COMENÇAMENT I FINALITZACIO *
;;;******************************

(defrule system-banner ""
  (declare (salience 10))
  =>
  (printout t crlf crlf)
  (printout t "Recomenacio de viatges (de moment nomes en base al presupost")
  (printout t crlf crlf))
