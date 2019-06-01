; Sun May 13 20:25:12 CEST 2018
; 
;+ (version "3.3.1")
;+ (build "Build 430")


(defclass %3ACLIPS_TOP_LEVEL_SLOT_CLASS "Fake class to save top-level slot information"
	(is-a USER)
	(role abstract)
	(single-slot Preu
		(type FLOAT)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(multislot Mitjans_de_transport
		(type STRING)
		(create-accessor read-write))
	(single-slot Nom
		(type STRING)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(single-slot Transport
		(type SYMBOL)
		(allowed-values Avio Vaixell Tren Cotxe)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(single-slot Visitas
		(type STRING)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(single-slot Duracio
		(type INTEGER)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(single-slot Allotjament-qualitat
		(type STRING)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(single-slot Tipus
		(type SYMBOL)
		(allowed-values Negocis Romantic Festa Cultural)
;+		(cardinality 0 1)
		(create-accessor read-write)))

(defclass Viatge
	(is-a USER)
	(role concrete)
	(single-slot Preu
		(type FLOAT)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(single-slot Duracio
		(type INTEGER)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(single-slot Allotjament-qualitat
		(type STRING)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(single-slot Nom
		(type STRING)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(single-slot Visitas
		(type STRING)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(single-slot Transport
		(type SYMBOL)
		(allowed-values Avio Vaixell Tren Cotxe)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(single-slot Tipus
		(type SYMBOL)
		(allowed-values Negocis Romantic Festa Cultural)
;+		(cardinality 0 1)
		(create-accessor read-write)))




; Sun May 13 20:25:12 CEST 2018
; 
;+ (version "3.3.1")
;+ (build "Build 430")


;;; Creem les inst.
(defrule crea-instancia-inicial
	(declare (salience 10))
	 =>
	(make-instance KB_598930_Instance_13 of  Viatge

		(Allotjament-qualitat "Hotel1 4*")
		(Duracio 2)
		(Nom "Paris")
		(Preu 400.0)
		(Tipus Romantic)
		(Transport Avio)
		(Visitas "Torre Eiffel"))

	(make-instance KB_598930_Instance_14 of  Viatge

		(Allotjament-qualitat "Camping 1*")
		(Duracio 4)
		(Nom "Paris")
		(Preu 300.0)
		(Tipus Romantic)
		(Transport Cotxe)
		(Visitas "Museo Lepend"))

	(make-instance KB_598930_Instance_15 of  Viatge

		(Allotjament-qualitat "Hotel la canya 3*")
		(Duracio 6)
		(Nom "Paris")
		(Preu 900.0)
		(Tipus Romantic)
		(Transport Cotxe)
		(Visitas "Notre Dame"))

	(make-instance KB_598930_Instance_16 of  Viatge

		(Allotjament-qualitat "Hotel1 4*")
		(Duracio 5)
		(Nom "Paris")
		(Preu 650.0)
		(Tipus Romantic)
		(Transport Tren)
		(Visitas "Pergamo"))

	(make-instance KB_598930_Instance_17 of  Viatge

		(Allotjament-qualitat "Camping 1*")
		(Duracio 3)
		(Nom "Paris")
		(Preu 260.0)
		(Tipus Romantic)
		(Transport Tren)
		(Visitas "Charlie y la fabrica de chocolate"))

	(make-instance KB_598930_Instance_18 of  Viatge

		(Allotjament-qualitat "Airbnb")
		(Duracio 15)
		(Nom "Paris")
		(Preu 1600.0)
		(Tipus Romantic)
		(Transport Avio)
		(Visitas "Orsay"))
)


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
	(printout t crlf  "El viatge recomenat es:" crlf)
  (if (> (length$ ?v) 0) then
   (loop-for-count (?i 1 (length$ ?v))
     (send (nth$ ?i ?v) print)
	 (printout t crlf)	 
   )
 )
)







;;-----------------
;;-----------------

(defrule preu-viatge-alt
 (presupost alt)
 (preferencia-transport qualsevol)
 =>  
  (imprime-tot(find-instance ((?ins Viatge)) (> ?ins:Preu 700)))
)

(defrule preu-viatge-mitja
 (presupost mitja)
 (preferencia-transport qualsevol)
 =>  
  (imprime-tot (find-instance ((?ins Viatge))
  					 (and (<= ?ins:Preu 700) (> ?ins:Preu 300 ))))
)

(defrule preu-viatge-baix
 (presupost baix)
 (preferencia-transport qualsevol)
 =>    
  (imprime-tot (find-instance ((?ins Viatge))
  					 (and (< ?ins:Preu 300) (> ?ins:Preu 50 ))))
)




(defrule preu-viatge-alt2
 (presupost alt)
 (and(preferencia-transport ?x)(not(preferencia-transport qualsevol)))
 =>  
  (imprime-tot (find-instance ((?ins Viatge)) (and(> ?ins:Preu 700)(eq ?ins:Transport ?x))))
)

(defrule preu-viatge-mitja2
 (presupost mitja)
 (and(preferencia-transport ?x)(not(preferencia-transport qualsevol)))
 =>  
  (imprime-tot (find-instance ((?ins Viatge))
  					 (and (<= ?ins:Preu 700) (> ?ins:Preu 300 )(eq ?ins:Transport ?x))))
)

(defrule preu-viatge-baix2
  ?x <- (object(is-a Viatge))
 (presupost baix)
 (and(preferencia-transport ?x)(not(preferencia-transport qualsevol)))
 =>    
  (imprime-tot (find-instance ((?ins Viatge))
  					 (and (< ?ins:Preu 300) (> ?ins:Preu 50 )(eq ?ins:Transport ?x))))
)



;----------------------
;----------------------
;----------------------

(defrule carnet-conduir "Determina si es te carnet per a conduir"
  (preferencia-transport coche)
  (not(carnet-conduir ?))
  =>
  (if(yes-or-no-p "Tens l'acreditació necessaria per a conduir el coche? (yes/no)")
    then (assert(carnet-conduir si))
    else 
      (assert(carnet-conduir no))
      (assert(problemes "No pots conduir un cotxe si no tens carnet de conduir"))
  )
)

(defrule preferencies-transport "determina la preferencia en el transport"
  (not(preferencia-transport ?))
  =>
  (if (yes-or-no-p "Hi ha alguna preferencia en quant a transport es refereix?(yes/no)")
    then 
      (printout t "Indiqui quin es el transport que prefereix fer servir:" crlf "(Avio/Tren/Coche)")
      (bind ?prefer (read))
      (if (or (eq ?prefer Avio)(eq ?prefer Tren)(eq ?prefer Coche))
        then (assert(preferencia-transport ?prefer))
      )
    else (assert(preferencia-transport qualsevol))
  )
)

(defrule determina-presupost "Preguntem sobre el presupost"
  (not(presupost ?))
  =>
  (printout t "Quin es el presupost per persona per a tot el viatge?" crlf "(baix(50-300€) / mitja(301-700€) / alt(+700€))")
  (bind ?pres (read))
  (if (or (eq ?pres baix)(eq ?pres mitja)(eq ?pres alt))
    then (assert(presupost ?pres))
  )
)


(defrule determina-atoritzacio "Determinem si tenen autorització o no"
  (edat petits)
  (not(autoritzacio ?))
  =>
  (if (yes-or-no-p "Tens/teniu autorització d'un parent o tutor per a fer aquest viatge? (yes/no)")
    then (assert (autoritzacio si))
    else (assert (autoritzacio no))
        (assert(problemes "No et podem personalitzar cap viatge. Abans necessites l'autorització d'un parent o tutor"))
  )
)


(defrule determina-edat "determinem la franja d'edat"
  (not(companyia familia))
  (not(edat ?))
  =>
  (if (yes-or-no-p "La mitjana d'edat esta entre els 18 i els 35 anys? (yes/no)")
    then (assert(edat joves))
    else
      (if (yes-or-no-p "La mitjana d'edat esta entre els 36 i els 50 anys? (yes/no)")
        then (assert(edat adults))
        else 
          (if (yes-or-no-p "La mitjana d'edat és major als 50 anys? (yes/no)")
            then (assert(edat grans))
            else (assert(edat petits))
          )          
      )
  )
)

(defrule Benvinguda ""
	(not (parella ?))
	=>
	(if (yes-or-no-p "Tens l'objectiu de planejar un viatge en parella? (yes/no)")
	then (assert(parella si))
	else 
		(assert(parella no))
		(assert(problemes "No et podem personalitzar cap viatge.
		Estem especialitzats en viatges de parella només"))
	)
)

(defrule system-banner ""
 ;;; (declare (salience 100))
  =>
  (printout t crlf crlf)
  (printout t "Benvingut/da al sistema de personalització de viatges")
  (printout t crlf crlf))

(defrule print-problemes ""
 ;;; (declare (salience 100))
  (problemes ?item)
  =>
  (printout t crlf crlf)
  (format t " %s%n%n%n" ?item)
  (halt)
)

