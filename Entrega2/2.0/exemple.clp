; Thu May 10 19:10:04 CEST 2018
; CLASSES
;+ (version "3.3.1")
;+ (build "Build 430")


(defclass %3ACLIPS_TOP_LEVEL_SLOT_CLASS "Fake class to save top-level slot information"
	(is-a USER)
	(role abstract)
	(single-slot Preu
		(type FLOAT)
		;;;;(range 1.0 %3FVARIABLE)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(single-slot TipusTrans
		(type STRING)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(single-slot KB_986393_Slot_8
		(type STRING)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(single-slot NomCiutat
		(type STRING)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(single-slot PreuAllotjament
		(type FLOAT)
		;;(range 1.0 %3FVARIABLE)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(single-slot KB_986393_Slot_14
		(type INTEGER)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(multislot Llocs_per_dormir
		(type INSTANCE)
;+		(allowed-classes Allotjament)
		(create-accessor read-write))
	(single-slot Mitjans_de_transport
		(type INSTANCE)
;+		(allowed-classes Transport)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(single-slot Nom
		(type STRING)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(single-slot TipusAllotjament
		(type STRING)
;+		(cardinality 0 1)
		(create-accessor read-write)))

(defclass Viatge 
	(is-a USER)
	(role concrete)
	(multislot Mitjans_de_transport
		(type STRING)

;+		(cardinality 0 1)
		(create-accessor read-write))
	(multislot Llocs_per_dormir
		(type INSTANCE)
;+		(allowed-classes Allotjament)
		(create-accessor read-write))

	(single-slot Nom
		(type STRING)
;+		(cardinality 0 1)
		(create-accessor read-write)))

(defclass Ciutat
	(is-a USER)
	(role concrete)
	(single-slot NomCiutat
		(type STRING)
;+		(cardinality 0 1)
		(create-accessor read-write)))

(defclass Allotjament
	(is-a Ciutat)
	(role concrete)
	(single-slot PreuAllotjament
		(type FLOAT)
		;;(range 1.0 %3FVARIABLE)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(single-slot TipusAllotjament
		(type STRING)
;+		(cardinality 0 1)
		(create-accessor read-write)))

(defclass Transport
	(is-a USER)
	(role concrete)
	(single-slot Preu
		(type FLOAT)
		;;(range 1.0 %3FVARIABLE)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(single-slot TipusTrans
		(type STRING)
;+		(cardinality 0 1)
		(create-accessor read-write))
)

(defrule h ""
(declare(salience 10))
=>
	(make-instance projecte1_Instance_15 of Allotjament

		(NomCiutat "Paris")
		(PreuAllotjament 50.0)
		(TipusAllotjament "Hotel"))

	(make-instance projecte1_Instance_16 of Allotjament

		(NomCiutat "Paris")
		(PreuAllotjament 25.0)
		(TipusAllotjament "Apartament"))

	(make-instance projecte1_Instance_17 of  Allotjament

		(NomCiutat "Amsterdam")
		(PreuAllotjament 60.0)
		(TipusAllotjament "Hotel"))

	(make-instance projecte1_Instance_18 of  Transport

		(Preu 100.0)
		(TipusTrans "cotxe"))

	(make-instance projecte1_Instance_19 of  Transport

		(Preu 200.0)
		(TipusTrans "Avio"))

	(make-instance projecte1_Instance_20 of  Transport

		(Preu 75.0)
		(TipusTrans "tren")
	)

)




; ******************
; ******************
;*** Funcions
; ******************
; ******************





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
       else FALSE
    )
)

;;;(defmodule MAIN (export ?ALL))

(deffunction imprime-tot (?v)  
  (if (> (length$ ?v) 0) then
   (loop-for-count (?i 1 (length$ ?v))
     (send (nth$ ?i ?v) print)
	 (printout t crlf)	 
   )
 )
)

;;; Message handler para la clase PC, 
;;; imprime todos los slots de la clase
(defmessage-handler Viatge imprime primary ()
 (printout t "Transport: " crlf)
 (printout t ?self:Mitjans_de_transport)
 (printout t crlf) 
 (printout t "Allotjament: " crlf)
	(if (> (length$ ?self:Llocs_per_dormir) 0) then
	   (loop-for-count (?i 1 (length$ ?self:Llocs_per_dormir))
	     (send (nth$ ?i  ?self:Llocs_per_dormir) imprime_lloc)
		 (printout t crlf)	 
	   )
    )
 (printout t crlf) 
 (printout t "Ciutat: " ?self:Nom crlf crlf)
)

(defmessage-handler Allotjament imprime_lloc primary ()
	(printout t ?self:TipusAllotjament)
)



;;; ----------------------------------------------------------
;;; Template del resultado
(deftemplate consell "Lista de Valors de viatge que cumplen las caracteristicas deseadas"
  (slot TRIP)
)


; ******************
; ******************
;*** Rules
; ******************
; ******************


(defrule resultado-consejo "Regla salida de consejo"
 (declare (salience 10))
 (consell (TRIP ?r))
  =>
  (printout t "---------------------------------" crlf)
  (printout t "El viatge que millor s'adapta a les seves necessitats es: " crlf)
  (printout t crlf (class ?r) crlf crlf)
  (send ?r imprime)
  (printout t crlf)
  (halt)
)



(defrule det-companyia "analitzem amb quin tipus de companyia farà el viatge"
  (not (companyia ?))
  =>
  (if(yes-or-no-p "Viatges sol? (yes/no)")
    then (assert(companyia sol))
    else
      (printout t "Amb quina companyia viatges? (familia/amics/parella/altre)" crlf)
      (bind ?comp (read))
      (if (or (eq ?comp familia)(eq ?comp amics)(eq ?comp parella)(eq ?comp altre))
        then (assert(companyia ?comp))
      )
  )
)


;;; Creamos la instancia sobre la que trabajaremos
(defrule crea-instancia-inicial
 (declare (salience 10))
 =>
 (make-instance [p] of Viatge)
)

(defrule assignatot ""
	?x <- (object (is-a Viatge))
	(companyia ?)
	
	=>
	(slot-insert$ ?x Llocs_per_dormir 1 (find-instance((?ins Allotjament)) (eq ?ins:TipusAllotjament "Apartament")))
	(slot-insert$ ?x Mitjans_de_transport 1 "avio")
	(send ?x put-Nom "Carla")
)


;;; Crea el template consejo con la solucion
(defrule solucion-domestico
 (declare (salience -1))
 ?x <- (object (is-a Viatge))
 =>
 (assert (consell (TRIP ?x)))
)
 