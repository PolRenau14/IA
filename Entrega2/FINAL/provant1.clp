(deffunction distancia-haversine (?lat1 ?long1 ?lat2 ?long2)
  ;;;Conversio graus a radians
  (bind ?lat1 (* ?lat1 6.283185))
  (bind ?lat1 (/ ?lat1 360))
  (bind ?lat2 (* ?lat2 6.283185))
  (bind ?lat2 (/ ?lat2 360))
  (bind ?long1 (* ?long1 6.283185))
  (bind ?long1 (/ ?long1 360))
  (bind ?long2 (* ?long2 6.283185))
  (bind ?long2 (/ ?long2 360))

  ;;;Calcul de la primera part de la formula
  (bind ?part1 ?lat2)
  (bind ?part1 (- ?part1 ?lat1))
  (bind ?part1 (/ ?part1 2))
  (bind ?part1 (sin ?part1))
  (bind ?part1 (* ?part1 ?part1))

  ;;;Calcul de la segona part de la formula
  (bind ?part2 ?long2)
  (bind ?part2 (- ?part2 ?long1))
  (bind ?part2 (/ ?part2 2))
  (bind ?part2 (sin ?part2))
  (bind ?part2 (* ?part2 ?part2))
  (bind ?part2 (* ?part2 (cos ?lat2)))
  (bind ?part2 (* ?part2 (cos ?lat1)))

  ;;Calcul del resultat final
  (bind ?res ?part1)
  (bind ?res (+ ?res ?part2))
  (bind ?res (sqrt ?res))
  (bind ?res (asin ?res))
  (bind ?res (* ?res 6371))
  (bind ?res (* ?res 2))  
  ?res
)

;;****************
;;* Altres *
;;****************


;;;(defmodule MAIN (export ?ALL))



(deffunction imprime-tot (?v)  
  (if (> (length$ ?v) 0) then
   (loop-for-count (?i 1 (length$ ?v))
     (send (nth$ ?i ?v) print)
   (printout t crlf)   
   )
 )
)



;;; Template del resultado
(deftemplate consell "Lista de Valors de viatge que cumplen las caracteristicas deseadas"
  (slot TRIP)
)

(deftemplate sol_parcial " valors que seran per calcular la solució"
  (multislot ciuts)
)



;;; Creamos la instancia sobre la que trabajaremos
(defrule crea-instancia-inicial
 (declare (salience 10))
 =>
 (make-instance [p] of Viatge)
)

(defrule assigna_transport_entre_ciutats ""
  ?x <- (object(is-a Viatge))
  (preferencia-transport ?prefe)
  (ciutats colocades)
  =>
  (bind ?prova (send ?x get-ciutats_visitades))
  (bind ?lat_o 41.3818)
  (bind ?lon_o 2.1685)
  (loop-for-count (?i 1 (length$ ?prova))
    (bind ?c (nth$ ?i ?prova))
    (bind ?lat_d(send ?c get-latitud))
    (bind ?lon_d(send ?c get-longitud))
    (bind ?dist (distancia-haversine ?lat_o ?lon_o ?lat_d ?lon_d))
    (bind ?lon_o ?lon_d )
    (bind ?lat_o ?lat_d)
  )
)

(defrule assigna_ciutats " assignem les ciutats que visitaran "
  ?x <- (object (is-a Viatge))
  (companyia ?comp)
  (tipus-viatge ?t_viatge)
  (llocs ?site)
  (preferencia-transport ?prefe)
  =>
  (if (eq ?prefe vaixell) 
    then
      (bind ?v TRUE)
      (bind ?te FALSE)
    else 
      (bind ?v FALSE)
      (if (or(eq ?prefe cotxe)(eq ?prefe tren)(eq ?prefe autobus))
        then
        (bind ?te TRUE)
        else 
        (bind ?te FALSE)
      )
  )
  (if (eq ?comp familia)
      then
      (if (eq ?t_viatge relaxat)
        then
          (bind ?ciut (find-all-instances((?ins Ciutat)) (and(eq ?ins:bona_per_familia TRUE)(eq ?ins:te_port ?v)(eq ?ins:te_carretera ?te)( eq ?ins:bona_per_relax TRUE) ( eq ?ins:bona_per_festa FALSE))))
        else  
          (bind ?ciut (find-all-instances((?ins Ciutat)) (and(eq ?ins:bona_per_familia TRUE)(eq ?ins:te_port ?v)(eq ?ins:te_carretera ?te))))
      )
      else 
        
        (bind ?ciut (find-all-instances((?ins Ciutat)) (and(eq ?ins:bona_per_negoci TRUE)(eq ?ins:te_port ?v)(eq ?ins:te_carretera ?te))))
  )
  (if (< ?site (length$ ?ciut))
    then  
    (loop-for-count ( ?i 1 ?site)
    (bind ?d (nth$ ?i ?ciut ))
    (slot-insert$ ?x ciutats_visitades 1 ?d))
    (assert (ciutats colocades))
    else 
    (slot-insert$ ?x ciutats_visitades 1 ?ciut)
    (assert (condicions no_es_poden_complir))
    )

)






;;;**********************
;;;* ENGINE STATE RULES *
;;;**********************
;;****************
;;* DEFFUNCTIONS *
;;****************



(deffunction MAIN::pregunta-num (?pregunta)
      (format t "%s " ?pregunta)
      (bind ?respuesta (read))
      (while (not (integerp ?respuesta)) do
        (format t "%s " ?pregunta)
        (bind ?respuesta (read))
      )
      ?respuesta
    )

    (deffunction MAIN::pregunta-opciones (?question $?allowed-values)
       (format t "%s "?question)
       (progn$ (?curr-value $?allowed-values)
        (format t "[%s]" ?curr-value)
      )
       (printout t ": ")
       (bind ?respuesta (read))
       (if (lexemep ?respuesta)
           then (bind ?respuesta (lowcase ?respuesta)))
       (while (not (member$ ?respuesta ?allowed-values)) do
          (format t "%s "?question)
        (progn$ (?curr-value $?allowed-values)
        (format t "[%s]" ?curr-value)
        )
        (printout t ": ")
          (bind ?respuesta (read))
          (if (lexemep ?respuesta)
              then (bind ?respuesta (lowcase ?respuesta))))
       ?respuesta
    )

(deffunction ask-question (?question $?allowed-values)
   (printout t ?question crlf)
   (bind ?answer (read))
   (if (lexemep ?answer) 
       then (bind ?answer (lowcase ?answer)))
   (while (not (member$ ?answer ?allowed-values)) do
      (printout t ?question crlf)
      (bind ?answer (read))
      (if (lexemep ?answer) 
          then (bind ?answer (lowcase ?answer))))
   ?answer)

(deffunction yes-or-no-p (?question)
   (bind ?response (ask-question ?question yes no y n))
   (if (or (eq ?response yes) (eq ?response y))
       then TRUE 
       else FALSE))


(deffunction franga-edat (?answer)
(if (and (>= ?answer 18)(< ?answer 36))
    then (assert(edat joves))
    else
      (if (and (>= ?answer 36)(< ?answer 51))
        then (assert(edat adults))
        else 
          (if (>= ?answer 51)
            then (assert(edat grans))
            else (assert(edat petits))
          )          
      )
  )
)

;;;**********************
;;;* ENGINE STATE RULES *
;;;**********************

(defrule auto ""
  (declare (salience 100))
  (infants no)
  =>
  (assert(autoritzacio no-cal))
)

(defrule Viatjant-sol ""
  (declare (salience 100))
  (companyia sol)
  =>
  (assert(tamany 1))
  (assert (tipus-tamany petit))
)

(defrule Viatge-parella ""
  (declare (salience 100))
  (companyia parella)
  =>
  (assert(tamany 2))
  (assert (tipus-tamany petit))
)

(defrule Autonomia-vehicles ""
  (declare (salience 100))
  (or(preferencia-transport avio)(preferencia-transport vaixell)(preferencia-transport tren))
  =>
  (assert(autonomia-transport no-pot))
)

(defrule qualitat-avio-negoci ""
  (declare (salience 100))
  (and (preferencia-transport avio)(tipus-viatge negoci))
  =>
  (assert (qualitat-avio preferent))
)

;;;***************
;;;* QUERY RULES *
;;;***************

(defrule peatges "Determina si vols passar per peatges amb coche"
  (preferencia-transport coche)
  (not (peatge-coche))
  =>
  (if (yes-or-no-p "Vol pagar peatges durant el seu trajecte amb coche? (yes/no)")
    then (assert (peatge-coche si))
    else (assert (peatge-coche no))
  )
)

(defrule qualitat-avio "Determina el seient en le avio"
  (preferencia-transport avio)
  (not (qualitat-avio))
  =>
  (bind ?question "Indiqui en quin tipus de butaca desitja viatjar en el avió: preferent/normal/indiferent")
  (bind ?answer (ask-question ?question preferent normal indiferent))
  (assert (qualitat-avio ?answer))
)

(defrule qualitat-vaixell "Determina la qualitat del viatge amb vaixell"
  (preferencia-transport vaixell)
  (not (qualitat-vaixell))
  =>
  (bind ?question "Indiqui quina preferència té de cara al tipus de servei en el vaixell: camerino/butaca/indiferent")
  (bind ?answer (ask-question ?question camerino butaca indiferent))
  (assert (qualitat-vaixell ?answer))
)

(defrule clima "Determina e clima desitjat"
  (not (clima ?))
  =>
  (bind ?question "Indiqui quin tipus de clima desitjaria tenir en la/s ciutat/s que visitarà: nevat/plujos/solejat/parcialment-solejat/nubol/vent/indiferent")
  (bind ?answer (ask-question ?question nevat plujos solejat parcialment-solejat nubol vent indiferent))
  (assert (clima ?answer))
)

(defrule animals "Determina si el allotjament vols que es permetin animals"
  (not (permet-animals ?))
  =>
  (if (yes-or-no-p "Voldrà que es permeti l'entrada d'animals domèstics al allotjament on farà estància? (yes/no)")
    then (assert (permet-animals si))
    else (assert (permet-animals no))
  )  
)

(defrule prescindir "Determina si prescindir si sobrepassa el pressupost"
  (or(presupost baix)(presupost mitja))
  (not(prescindir-pressupost ?))
  =>
  (if(yes-or-no-p "En cas que es sobrepassi el seu pressupost, voldrà prescindir d'alguna de les prefrencies indicades previament? (yes/no=acceptara el pressupost)")
    then (assert (prescindir-pressupost si))
    else (assert (prescindir-pressupost no))
  )
)

(defrule ciutats "Determina el nombre de ciutats diferents per les que vol passar"
  (not(preferencia-lloc ?))
  (not(llocs ?))
  =>
  (bind ?question "Prefereix visitar ciutats/llocs molt turístics o en prefereix d'altres poc coneguts? (turistics/preferiblement-turistics/preferiblement-desconeguts/desconeguts)")
  (bind ?answer (ask-question ?question turistics preferiblement-turistics preferiblement-desconeguts desconeguts))
  (assert(preferencia-lloc ?answer))

  (bind ?answer (pregunta-num "Indiqui la quantitat de llocs diferents que vol visitar:"))
  (assert (llocs ?answer))
)

(defrule temps "Determina el temps que ha de durar el viatge"
  (not(temps ?))
  =>
   (bind ?answer (pregunta-num "Indiqui la quantitat de dies que vol que duri el viatge: "))
   (assert (temps ?answer))
)

(defrule aparcament "Determina si vols aparcament en el allotjament on aniras"
  (or (preferencia-transport coche)(transport-urba coche))
  (not (aparcament ?))
  =>
  (bind ?question "Vol que el lloc on s'allotjarà tingui parquing? (si/preferiblement-si/preferiblement-no/no)")
  (bind ?answer (ask-question ?question si preferiblement-si preferiblement-no no))
  (assert (aparcament ?answer)) 
)

(defrule qualitat-hotel "Determina preferencies per allotjamnet"
  (not(and(preferencia-allotjament-qualitat ?)(preferencia-allotjament-tipus ?)))
  => 
  (if (yes-or-no-p "Tens alguna preferència de cara a la qualitat allotjament? (yes/no)")
    then
      (bind ?question "Indiqui la qualitat desitjada: baixa/estandar/alta/excel·lent")
      (bind ?answer (ask-question ?question baixa estandar alta excel·lent))
      (assert(preferencia-allotjament-qualitat ?answer))
    else (assert(preferencia-allotjament-qualitat no))
  )
  (if (yes-or-no-p "Tens alguna preferència de cara al tipus d'allotjament? (yes/no)")
    then 
      (bind ?question "Indiqui el tipus d'allotjament desitjat: hotel/apartament/camping/altres")
      (bind ?answer (ask-question ?question hotel apartament camping altres))
      (assert (preferencia-allotjament-tipus ?answer))
    else (assert(preferencia-allotjament-tipus no))
  )
)


(defrule carnet-conduir "Determina si es te carnet per a conduir"
  (preferencia-transport coche)
  (not(carnet-conduir ?))
  =>
  (if(yes-or-no-p "Tens l'acreditació necessaria per a conduir el transport desitjat? (yes/no)")
    then (assert(carnet-conduir si))
    else 
      (assert(carnet-conduir no))
      (assert(problemes "No pots conduir el vehicle desitjat si no tens l'acreditació necessaria"))
  )
)


(defrule coche-autonomia "Determina autonomia"
  (preferencia-transport coche)
  (not(autonomia-transport ?))
  =>
  (if (yes-or-no-p "Vols que el coche sigui llogat? (yes/no)")
    then (assert(autonomia-transport coche-no))
    else (assert(autonomia-transport coche-yes))
  )
)

(defrule transport-pel-lloc "determina com moure's per el lloc"
  (not (transport-local ?))
  =>
  (bind ?question "Indiqui amb quin tipus de transport es vol mobilitzar per la ciutat: autobus/metro/tren/coche/altre")
  (bind ?answer (ask-question ?question autobus metro tren coche altre))
  (assert(transport-urba ?answer))
)

(defrule preferencies-transport "determina la preferencia en el transport"
  (not(preferencia-transport ?))
  =>
  (if (yes-or-no-p "Hi ha alguna preferencia de transport per desplaçar-se entre destins?(yes/no)")
    then 
      (bind ?question "Indiqui quin es el transport que prefereix fer servir: avio/vaixell/tren/coche/autobus")
      (bind ?answer (ask-question ?question avio vaixell tren coche autobus))
      (assert(preferencia-transport ?answer))
    else (assert(preferencia-transport qualsevol))
  )
)

(defrule determina-presupost "Preguntem sobre el presupost"
  (not(presupost ?))
  =>
  (bind ?question "Quin es el presupost per persona per a tot el viatge? (baix(200-500€) / mitja(501-1000€) / alt(+1000€))")
  (bind ?answer (ask-question ?question baix mitja alt))
  (assert(presupost ?answer))
)


(defrule  determina-tipus "determinem el tipus de viatge"
  (not (tipus-viatge ?))
  =>
  (bind ?question "Com volen orientar el seu viatge? (cultural/relaxat/aventurer/festa/altre)")
  (bind ?answer (ask-question ?question cultural relaxat aventurer festa altre))
  (assert(tipus-viatge ?answer))
)


(defrule determina-tipus2 "determinem el tipus per una persona sola"
  (companyia sol)
  (not(tipus-viatge ?)) 
  =>
  (bind ?question "Com vol orientar el seu viatge? (negoci/cultural/relaxat/aventurer/altre)")
  (bind ?answer (ask-question ?question negoci cultural relaxat aventurer altre))
  (assert(tipus-viatge ?answer))
)


(defrule determina-atoritzacio "Determinem si tenen autorització o no"
  (or(edat petits)(infants si))
  (not(autoritzacio ?))
  =>
  (if (yes-or-no-p "Tens/teniu autorització d'un parent o tutor per a fer aquest viatge? (yes/no)")
    then (assert (autoritzacio si))
    else (assert (autoritzacio no))
        (assert(problemes "No et podem personalitzar cap viatge. Abans necessites l'autorització d'un parent o tutor"))
  )
)

(defrule deremina-edat2 "Determina si hi ha persones grans"
  (companyia familia)
  (not(edat ?))
  =>
  (if (yes-or-no-p "Viatjaran persones grans amb la família? (yes/no)")
    then (assert(edat totes))
    else (assert(edat no-avis))
  )
)

(defrule determina-menors "ens assegurem si hi ha o no menors d'edat al grup"
  (not(or(companyia familia)(companyia sol)))
  (not (infants ?))
  =>
  (if (yes-or-no-p "Hi ha algun menor d'edat al grup? (yes/no)")
    then (assert (infants si))
    else (assert (infants no))
  )
)

(defrule determina-edat "determinem la franja d'edat"
  (not(and(companyia familia)(companyia sol)))
  (not(and(edat ?)(edat-num ?)))
  =>
  (bind ?answer (pregunta-num "Quina es la mitjana d'edat del grup?"))
  (assert (edat-num ?answer))
  (franga-edat ?answer)
)

(defrule determina-edat2 "edat"
  (companyia sol)
  (not (and(edat ?)(edat-num ?)))
  =>
  (bind ?answer (pregunta-num "Quina es la seva edat?"))
  (assert (edat-num ?answer))
  (franga-edat ?answer)
)


(defrule determina-persones "Definim el tamany del grup"
  (or (companyia familia)(companyia amics)(companyia altres))
  (not(tamany ?))
  (not(tipus-tamany ?))
  =>
  (bind ?answer (pregunta-num "Quantes persones viatjareu?"))
  (assert (tamany ?answer))
  (if(>= ?answer 10)
    then (assert(tipus-tamany gran))
    else
      (if (>= ?answer 5)
        then (assert(tipus-tamany mitja))
        else (assert(tipus-tamany petit))
      )
  )
)


(defrule det-companyia "analitzem amb quin tipus de companyia farà el viatge"
  (not (companyia ?))
  =>
  (if(yes-or-no-p "Viatges sol? (yes/no)")
    then (assert(companyia sol))
    else
      (bind ?question "Amb quina companyia viatges? (familia/amics/parella/altre)")
      (bind ?comp (ask-question ?question familia amics parella altre))
      (assert(companyia ?comp))   
  )
)


(defrule nombre "es una prova"
  (not(nom ?))
  =>
  (printout t "Quin es el teu nom? " crlf)
  (bind ?nom1 (read))
  (assert(nom ?nom1))
)

;;;****************************
;;;* STARTUP AND REPAIR RULES *
;;;****************************

(defrule system-banner ""
 ;;; (declare (salience 100))
  =>
  (printout t crlf crlf)
  (printout t "Sistema de personalització de viatges")
  (printout t crlf crlf))

(defrule print-repair ""
 ;;; (declare (salience 100))
  (problemes ?item)
  =>
  (printout t crlf crlf)
  (format t " %s%n%n%n" ?item)
  (halt)
)

;;;****************
;;;**FI PREGUNTES**
;;;****************

;;; Crea el template consejo con la solucion
(defrule solucion-domestico
 (declare (salience -1))
 ?x <- (object (is-a Viatge))
 =>
 (assert (consell (TRIP ?x)))
)

(defmessage-handler Viatge imprime primary ()

 (imprime-tot ?self:ciutats_visitades)
 (printout t (length$ ?self:ciutats_visitades))

)

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