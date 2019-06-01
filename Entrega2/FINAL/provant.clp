;;**************
;;* DEFMODULES *
;;**************


(defmodule MAIN 
  (export ?ALL)
)

(deffunction minimum-slot (?li ?sl ?init)
 (bind ?min ?init)
 (loop-for-count (?i 1 (length$ ?li))
   (bind ?v (send (nth$ ?i ?li) ?sl))
   (if (< ?v ?min)
     then 
    (bind ?min ?v)
    (bind ?ins (nth$ ?i ?li))
  )
  )
 (return ?ins)
)

(deffunction turistic (?dist) "determia si la dist es bona per turisme."
  (if (<= ?dist 2.0)
    then TRUE
    else FALSE
    )
)
(deffunction pref-turistic (?dist) "determia si la dist es bona per pref-turisme."
  (if (<= ?dist 6.0)
    then TRUE
    else FALSE
    )
)

(deffunction pref-desconegut (?dist) "determia si la dist es bona per pref-desconegut."
  (if (>= ?dist 5.0)
    then TRUE
    else FALSE
    )
)
(deffunction desconegut (?dist) "determia si la dist es bona per desconegut."
  (if (>= ?dist 8.0)
    then TRUE
    else FALSE
    )
)

(deffunction allotjament_interes (?prefe ?dist) "determina si el allotjament es turistic o no"
  (if(eq ?prefe indiferent)
    then TRUE
    else 
      (if(eq ?prefe turistics)
        then 
        (bind ?ret(turistic ?dist))
        ?ret
        else 
          (if (eq ?prefe preferiblement-turistics)
            then
            (bind ?ret(pref-turistic ?dist))
            ?ret
            else
              (if (eq ?prefe preferiblement-desconegut)
                then
                  (bind ?ret(pref-desconegut ?dist))
                  ?ret
                else
                  (bind ?ret(desconegut ?dist))
                  ?ret
              )
          )
      )
  )
) 

(deffunction determina-parking (?aparc ?te_parquing) 
  (if (eq ?aparc indiferent)
  then
    TRUE
  else 
    (if (eq ?aparc si)
    then
      (bind ?ret(eq ?te_parquing TRUE))
    else
      (bind ?ret(eq ?te_parquing FALSE))
    )
    ?ret
  )
)

(deffunction determina-animals (?animals ?permet_animals) 
  (if (eq ?animals indiferent)
  then
    TRUE
  else 
    (if (eq ?animals si)
    then
      (bind ?ret(eq ?permet_animals TRUE))
    else
      (bind ?ret(eq ?permet_animals FALSE))
    )
    ?ret
  )
)

(deffunction comprova-clima (?clim ?clima_ciutat)
  (if(eq ?clim indiferent)
    then TRUE
    else
    (bind ?ret(eq ?clim ?clima_ciutat))
    ?ret
  )
)

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

(deffunction rand (?li)
  (bind ?li (create$ ?li))
  (bind ?max (length$ ?li))
  (bind ?r (random 1 ?max))
  (bind ?ins (nth$ ?r ?li))
  ?ins
)

(deffunction imprime-tot (?v)  
  (if (> (length$ ?v) 0) then
   (loop-for-count (?i 1 (length$ ?v))
     (send (nth$ ?i ?v) print)
   (printout t crlf)   
   )
 )
)

(deffunction MAIN::pregunta-num (?pregunta)
      (format t "%s " ?pregunta)
      (bind ?respuesta (read))
      (while (not (integerp ?respuesta)) do
        (format t "%s " ?pregunta)
        (bind ?respuesta (read))
      )
      ?respuesta
)

(deffunction MAIN::mes-petit-que (?lloc ?dia ?pregunta)
  (while (> ?lloc ?dia) 
    (bind ?lloc (pregunta-num ?pregunta))
  )
  ?lloc
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
   ?answer
)

(deffunction yes-or-no-p (?question)
   (bind ?response (ask-question ?question si no s n))
   (if (or (eq ?response yes) (eq ?response y))
       then TRUE 
       else FALSE)
)


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

(deffunction minim_preu (?preu_min ?li ?sl ?init)
 (bind ?min ?init)
 (loop-for-count (?i 1 (length$ ?li))
   (bind ?v (send (nth$ ?i ?li) ?sl))
   (if (and(< ?v ?min)(> ?v ?preu_min))
     then 
      (bind ?min ?v)
      (bind ?ins (nth$ ?i ?li))
   )
  )
 ?ins
)

(deffunction tipolloc (?tipus ?requerit)
  (bind ?sol no)
  (loop-for-count (?i 1 (length$ ?tipus))
    (bind ?tip_act (nth$ ?i ?tipus))
    (if (eq ?tip_act ?requerit)
      then 
        (bind ?sol ?requerit)
    )
  )
  ?sol
)

(deffunction det-qualitat-avio (?q_a ?trans)
  (if (eq ?q_a indiferent)
    then TRUE
    else 
      (if (eq ?q_a preferent)
        then 
          (bind ?ret(eq ?trans TRUE))
        else
          (bind ?ret(eq ?trans FALSE))
      )
      ?ret
  )
)

(deffunction det-qualitat-vaixell (?q_v ?trans)
  (if (eq ?q_v indiferent)
    then TRUE
    else 
      (if (eq ?q_v camarot)
        then 
          (bind ?ret(eq ?trans TRUE))
        else
          (bind ?ret(eq ?trans FALSE))
      )
      ?ret
  )
)

(deffunction return-primer (?li)
  (bind ?ret(nth$ 1 ?li))
  ?ret
)

;;****************
;;* DEFTEMPLATES *
;;****************

;;; Template del resultado
(deftemplate consell "Lista de Valors de viatge que cumplen las caracteristicas deseadas"
  (slot TRIP)
  (slot TRIP2)
)

(deftemplate sol_parcial " valors que seran per calcular la solució"
  (multislot ciuts)
)

;;***************
;;*  INSTANCES  *
;;***************

;;; Creamos la instancia sobre la que trabajaremos
(defrule crea-instancia-inicial
 (declare (salience 10))
 =>
 (make-instance [p] of Viatge)
 (make-instance [p2] of Viatge2)
)

;;**********************
;;* ASSIGNACIO VIATGES *
;;**********************


(defrule Assigna-ciutats-visitades
  ?x <- (object(is-a Viatge))
  ?y <- (object(is-a Viatge2))
  (llocs ?l)
  =>
  (send ?x put-num_ciutats_visitades ?l)
  (send ?y put-num_ciutats_visitades ?l)
)

(defrule determina_preu_saltat_o_no ""
  ?x <- (object (is-a Viatge))
  ?y <- (object (is-a Viatge2))
  (or (presupost baix)(presupost mitja))
  (max_press ?maxpress)
  (prescindir-pressupost ?pres_pres)
  (and (transport_colocat)(llocs_colocats)(allotjaments-colocats))
  =>
  (bind ?viatgeact1 (send ?x get-preu_total))
  (bind ?viatgeact2 (send ?y get-preu_total))
  (if (or (> ?viatgeact1 ?maxpress)(> ?viatgeact2 ?maxpress))
    then 
      (if (eq ?pres_pres no)
        then 
          (assert (condicions no_es_poden_complir))
      )
  )
)


(defrule assigna_llocs_interes2 ""
  ?x <- (object(is-a Viatge2))
  (and (dies-per-ciutat-colocat)(ciutats-colocades))
  (tipus-viatge ?t_viatge)
  (temps ?temp)
  (llocs ?l)
  (presupost ?press)
  =>
  (bind ?ciutats (send ?x get-ciutats_visitades))
  (bind ?dies_x_ciutat (send ?x get-dies_per_ciutat))
  (loop-for-count (?j 1 ?l)
    (bind ?ciut_act (nth$ ?j ?ciutats))
    (bind ?ciut_act (send ?ciut_act get-nom_ciutat))
    (bind ?dies_ciut (nth$ ?j ?dies_x_ciutat))

    (if (eq ?t_viatge indiferent)
      then
        (bind ?poss_llocs (find-all-instances((?ins Llocs_interes))(eq ?ins:ciutat ?ciut_act)))
      else
        (bind ?poss_llocs (find-all-instances((?ins Llocs_interes))(and(eq ?ins:ciutat ?ciut_act)(eq ?t_viatge (tipolloc ?ins:tipus_lloc_int ?t_viatge)))))
    )

    (if (<= (* ?dies_ciut 2) (length$ ?poss_llocs))
      then
      (if (eq ?press alt)
        then  
          (loop-for-count (?i 1 (* ?dies_ciut 2))
            (bind ?d (nth$ ?i ?poss_llocs))
            (bind ?position (send ?x get-llocs_interes_per_dia))
            (slot-insert$ ?x llocs_interes_per_dia (+ 1 (length$ ?position)) ?d)
          )
        else 
          (bind ?suma_coloc 0)
          (loop-for-count (?i 1 (length$ ?poss_llocs))
            (bind ?d (nth$ ?i ?poss_llocs))
            (bind ?preuesito (send ?d get-preu_lloc_int))
            (if (< ?suma_coloc (* ?dies_ciut 2))
              then
              (if (= ?preuesito 0)
                then 
                  (bind ?position (send ?x get-llocs_interes_per_dia))
                  (slot-insert$ ?x llocs_interes_per_dia (+ 1 (length$ ?position)) ?d)
                  (bind ?suma_coloc (+ ?suma_coloc 1))
              )
            )
          )
          (if (< ?suma_coloc (* ?dies_ciut 2))
            then
            (bind ?min_act 0)
            (loop-for-count (?i (+ 1 ?suma_coloc) (* ?dies_ciut 2))
               (bind ?instanciaaposar (minim_preu ?min_act ?poss_llocs get-preu_lloc_int 100000000))
               (bind ?min_act (send ?instanciaaposar get-preu_lloc_int))
               (bind ?position (send ?x get-llocs_interes_per_dia))
               (slot-insert$ ?x llocs_interes_per_dia (+ 1 (length$ ?position)) ?instanciaaposar)
            )
          )
        )
      else
        (assert (llocs_insuficients))
        (loop-for-count (?i 1 (length$ ?poss_llocs))
            (bind ?d (nth$ ?i ?poss_llocs))
            (bind ?position (send ?x get-llocs_interes_per_dia))
            (slot-insert$ ?x llocs_interes_per_dia (+ 1 (length$ ?position)) ?d)
          )
    )
    (loop-for-count (?i 1 (length$ ?poss_llocs))
      (bind ?d (nth$ ?i ?poss_llocs))
      (bind ?preus (send ?d get-preu_lloc_int))
      (bind ?preutot (send ?x get-preu_total))
      (bind ?preunou (+ ?preus ?preutot))
      (send ?x put-preu_total ?preunou)
    )
  )
  (assert (llocs_colocats))
)

(defrule assigna_llocs_interes ""
  ?x <- (object(is-a Viatge))
  (and (dies-per-ciutat-colocat)(ciutats-colocades))
  (tipus-viatge ?t_viatge)
  (temps ?temp)
  (llocs ?l)
  (presupost ?press)
  =>
  (bind ?ciutats (send ?x get-ciutats_visitades))
  (bind ?dies_x_ciutat (send ?x get-dies_per_ciutat))
  (loop-for-count (?j 1 ?l)
    (bind ?ciut_act (nth$ ?j ?ciutats))
    (bind ?ciut_act (send ?ciut_act get-nom_ciutat))
    (bind ?dies_ciut (nth$ ?j ?dies_x_ciutat))

    (if (eq ?t_viatge indiferent)
      then
        (bind ?poss_llocs (find-all-instances((?ins Llocs_interes))(eq ?ins:ciutat ?ciut_act)))
      else
        (bind ?poss_llocs (find-all-instances((?ins Llocs_interes))(and(eq ?ins:ciutat ?ciut_act)(eq ?t_viatge (tipolloc ?ins:tipus_lloc_int ?t_viatge)))))
    )

    (if (<= (* ?dies_ciut 2) (length$ ?poss_llocs))
      then
      (if (eq ?press alt)
        then  
          (loop-for-count (?i 1 (* ?dies_ciut 2))
            (bind ?d (nth$ ?i ?poss_llocs))
            (bind ?position (send ?x get-llocs_interes_per_dia))
            (slot-insert$ ?x llocs_interes_per_dia (+ 1 (length$ ?position)) ?d)
          )
        else 
          (bind ?suma_coloc 0)
          (loop-for-count (?i 1 (length$ ?poss_llocs))
            (bind ?d (nth$ ?i ?poss_llocs))
            (bind ?preuesito (send ?d get-preu_lloc_int))
            (if (< ?suma_coloc (* ?dies_ciut 2))
              then
              (if (= ?preuesito 0)
                then 
                  (bind ?position (send ?x get-llocs_interes_per_dia))
                  (slot-insert$ ?x llocs_interes_per_dia (+ 1 (length$ ?position)) ?d)
                  (bind ?suma_coloc (+ ?suma_coloc 1))
              )
            )
          )
          (if (< ?suma_coloc (* ?dies_ciut 2))
            then
            (bind ?min_act 0)
            (loop-for-count (?i (+ 1 ?suma_coloc) (* ?dies_ciut 2))
               (bind ?instanciaaposar (minim_preu ?min_act ?poss_llocs get-preu_lloc_int 100000000))
               (bind ?min_act (send ?instanciaaposar get-preu_lloc_int))
               (bind ?position (send ?x get-llocs_interes_per_dia))
               (slot-insert$ ?x llocs_interes_per_dia (+ 1 (length$ ?position)) ?instanciaaposar)
            )
          )
        )
      else
        (assert (llocs_insuficients))
        (loop-for-count (?i 1 (length$ ?poss_llocs))
            (bind ?d (nth$ ?i ?poss_llocs))
            (bind ?position (send ?x get-llocs_interes_per_dia))
            (slot-insert$ ?x llocs_interes_per_dia (+ 1 (length$ ?position)) ?d)
          )
    )
    (loop-for-count (?i 1 (length$ ?poss_llocs))
      (bind ?d (nth$ ?i ?poss_llocs))
      (bind ?preus (send ?d get-preu_lloc_int))
      (bind ?preutot (send ?x get-preu_total))
      (bind ?preunou (+ ?preus ?preutot))
      (send ?x put-preu_total ?preunou)
    )
  )
  (assert (llocs_colocats))
)

(defrule assigna_dies_per_ciutat ""
  ?x <- (object(is-a Viatge))
  ?y <- (object(is-a Viatge2))
  (llocs ?l)
  (temps ?d)
  =>
  (bind ?smth (/ ?d ?l))
  (if (= (integer ?smth) 0)
    then
      (bind ?smth 1)
  )

  (bind ?diesperciutat (integer ?smth))
  (bind ?diesns (* ?diesperciutat ?l))
  (bind ?modul (- ?d ?diesns))
  (loop-for-count (?i 1 ?l)
    (slot-insert$ ?x dies_per_ciutat 1 ?diesperciutat)
    (slot-insert$ ?y dies_per_ciutat 1 ?diesperciutat)
  )
  (loop-for-count (?i 1 ?modul)
    (bind ?pos (random 1 ?l))
    (bind ?dcp2 (send ?x get-dies_per_ciutat))
    (bind ?elque (nth$ ?pos ?dcp2))
    (bind ?suma (+ ?elque 1))
    (slot-insert$ ?x dies_per_ciutat ?pos ?suma)
    (slot-insert$ ?y dies_per_ciutat ?pos ?suma)
  )
  (assert (dies-per-ciutat-colocat))
)


(defrule assigna_transport_entre_ciutats ""
  ?x <- (object(is-a Viatge))
  ?y <- (object(is-a Viatge2))
  (preferencia-transport ?prefe)
  (qualitat-avio ?q_a)
  (peatge-cotxe ?p_c)
  (qualitat-vaixell ?q_v)
  (ciutats-colocades)  
  =>
  (if (neq ?prefe qualsevol)
    then
      (bind ?t (find-instance((?ins Transport))(and(eq ?ins:tipus_transport ?prefe)(eq ?p_c ?ins:peatge)(eq (det-qualitat-vaixell ?q_v ?ins:camarot) TRUE)(eq (det-qualitat-avio ?q_a ?ins:preferent) TRUE))))
    else 
      (bind ?trans (find-all-instances((?ins Transport))(eq ?ins:tipus_transport avio)))
      (bind ?t(rand ?trans))
  )


  (bind ?prova (send ?x get-ciutats_visitades))
  (bind ?prova2 (send ?y get-ciutats_visitades))
  (slot-insert$ ?x transport_viatge 1 ?t)
  (slot-insert$ ?y transport_viatge 1 ?t)
  (assert (transport_colocat))
  (bind ?prov (send ?x get-transport_viatge))
  (bind ?prov2 (send ?y get-transport_viatge))
  (bind ?prov (nth$ 1 ?prov))
  (bind ?prov2 (nth$ 1 ?prov2))
  (bind ?preu_trans (send ?prov get-preu_per_km))
  (bind ?preu_trans2 (send ?prov2 get-preu_per_km))
  ;;;coords BCN que es sempre punt origen
  (bind ?lat_o 41.3818)
  (bind ?lon_o 2.1685)


  (loop-for-count (?i 1 (length$ ?prova))
    (bind ?c (nth$ ?i ?prova))
    (bind ?lat_d(send ?c get-latitud))
    (bind ?lon_d(send ?c get-longitud))
    (bind ?dist (distancia-haversine ?lat_o ?lon_o ?lat_d ?lon_d))
    (bind ?preu(send ?x get-preu_total))
    (bind ?preu (+ ?preu (* ?preu_trans ?dist)))
    (send ?x put-preu_total ?preu)    
    (bind ?lon_o ?lon_d )
    (bind ?lat_o ?lat_d)
  )

  (loop-for-count (?i 1 (length$ ?prova2))
    (bind ?c (nth$ ?i ?prova2))
    (bind ?lat_d(send ?c get-latitud))
    (bind ?lon_d(send ?c get-longitud))
    (bind ?dist (distancia-haversine ?lat_o ?lon_o ?lat_d ?lon_d))
    (bind ?preu(send ?y get-preu_total))
    (bind ?preu (+ ?preu (* ?preu_trans2 ?dist)))
    (send ?y put-preu_total ?preu)    
    (bind ?lon_o ?lon_d )
    (bind ?lat_o ?lat_d)
  )

  ;;;coords BCN
  (bind ?lat_d 41.3818)
  (bind ?lon_d 2.1685)
  (bind ?dist (distancia-haversine ?lat_o ?lon_o ?lat_d ?lon_d))   
  (bind ?preu(send ?x get-preu_total))
  (bind ?preu (+ ?preu (* ?preu_trans ?dist)))
  (send ?x put-preu_total ?preu) 

  (bind ?preu(send ?y get-preu_total))
  (bind ?preu (+ ?preu (* ?preu_trans2 ?dist)))
  (send ?y put-preu_total ?preu)   
)

(defrule asigna_allotjament3 "no importa tipus allotjament"
  ?x <- (object(is-a Viatge))
  (permet-animals ?p_a)
  (not (preferencia-allotjament-tipus ?))
  (not (preferencia-allotjament-qualitat ?))
  (preferencia-lloc ?p_ll)
  (aparcament ?aparc)
  (ciutats-colocades) 
  =>
  (bind ?ciutats (send ?x get-ciutats_visitades))
  (bind ?dies_per_ciutats(send ?x get-dies_per_ciutat))
  (bind ?stop FALSE)
  (loop-for-count (?i 1 (length$ ?ciutats))
    (bind ?c  (nth$ ?i ?ciutats ))
    (bind ?n_c( send ?c get-nom_ciutat))
    (bind ?a_p_c(find-instance((?ins Allotjament))(and(eq ?ins:ciutat_allotjament ?n_c)(eq (determina-parking ?aparc ?ins:te_parking) TRUE)(eq (determina-animals ?p_a ?ins:permet_animals) TRUE)(eq (allotjament_interes ?p_ll ?ins:dist_centre) TRUE))))
    (if(eq (length$ ?a_p_c) 0)
      then 
        (bind ?stop TRUE)
      else
          (slot-insert$ ?x allotjament_per_ciutat ?i ?a_p_c)
          (bind ?preu(send ?x get-preu_total))
          (bind ?prova(send ?x get-allotjament_per_ciutat))
          (bind ?prova1(nth$ ?i ?prova))

          (bind ?dies_per_ciutat(nth$ ?i ?dies_per_ciutats))
          (bind ?preu_allotja(send ?prova1 get-preu_allotjament))
          (bind ?preu (+ ?preu (* ?preu_allotja ?dies_per_ciutat)))
          (send ?x put-preu_total ?preu)   
    )
  )
  (if(eq ?stop FALSE)
    then
      (assert (allotjaments-colocats))
    else
      (assert (condicions no_es_poden_complir))
  )
)

(defrule asigna_allotjament32 "no importa tipus allotjament"
  ?x <- (object(is-a Viatge2))
  (permet-animals ?p_a)
  (not (preferencia-allotjament-tipus ?))
  (not (preferencia-allotjament-qualitat ?))
  (preferencia-lloc ?p_ll)
  (aparcament ?aparc)
  (ciutats-colocades) 
  =>
  (bind ?ciutats (send ?x get-ciutats_visitades))
  (bind ?dies_per_ciutats(send ?x get-dies_per_ciutat))
  (bind ?stop FALSE)
  (loop-for-count (?i 1 (length$ ?ciutats))
    (bind ?c  (nth$ ?i ?ciutats ))
    (bind ?n_c( send ?c get-nom_ciutat))
    (bind ?a_p_c(find-instance((?ins Allotjament))(and(eq ?ins:ciutat_allotjament ?n_c)(eq (determina-parking ?aparc ?ins:te_parking) TRUE)(eq (determina-animals ?p_a ?ins:permet_animals) TRUE)(eq (allotjament_interes ?p_ll ?ins:dist_centre) TRUE))))
    (if(eq (length$ ?a_p_c) 0)
      then 
        (bind ?stop TRUE)
      else
          (slot-insert$ ?x allotjament_per_ciutat ?i ?a_p_c)
          (bind ?preu(send ?x get-preu_total))
          (bind ?prova(send ?x get-allotjament_per_ciutat))
          (bind ?prova1(nth$ ?i ?prova))

          (bind ?dies_per_ciutat(nth$ ?i ?dies_per_ciutats))
          (bind ?preu_allotja(send ?prova1 get-preu_allotjament))
          (bind ?preu (+ ?preu (* ?preu_allotja ?dies_per_ciutat)))
          (send ?x put-preu_total ?preu)   
    )
  )
  (if(eq ?stop FALSE)
    then
      (assert (allotjaments-colocats))
    else
      (assert (condicions no_es_poden_complir))
  )
)

(defrule asigna_allotjament2 "no importa la qualitat"
  ?x <- (object(is-a Viatge))
  (permet-animals ?p_a)
  (preferencia-allotjament-tipus ?p_a_t)
  (not (preferencia-allotjament-qualitat ?))
  (preferencia-lloc ?p_ll)
  (aparcament ?aparc)
  (ciutats-colocades) 
  =>
  (bind ?ciutats (send ?x get-ciutats_visitades))
  (bind ?dies_per_ciutats(send ?x get-dies_per_ciutat))
  (bind ?stop FALSE)
  (loop-for-count (?i 1 (length$ ?ciutats))
    (bind ?c  (nth$ ?i ?ciutats ))
    (bind ?n_c( send ?c get-nom_ciutat))
    (bind ?a_p_c(find-instance((?ins Allotjament))(and(eq ?ins:ciutat_allotjament ?n_c)(eq (determina-parking ?aparc ?ins:te_parking) TRUE)(eq (determina-animals ?p_a ?ins:permet_animals) TRUE)(eq ?ins:tipus_allotjament ?p_a_t)(eq (allotjament_interes ?p_ll ?ins:dist_centre) TRUE))))
    (if(eq (length$ ?a_p_c) 0)
      then 
        (bind ?stop TRUE)
      else
          (slot-insert$ ?x allotjament_per_ciutat ?i ?a_p_c)
          (bind ?preu(send ?x get-preu_total))
          (bind ?prova(send ?x get-allotjament_per_ciutat))
          (bind ?prova1(nth$ ?i ?prova))

          (bind ?dies_per_ciutat(nth$ ?i ?dies_per_ciutats))
          (bind ?preu_allotja(send ?prova1 get-preu_allotjament))
          (bind ?preu (+ ?preu (* ?preu_allotja ?dies_per_ciutat)))
          (send ?x put-preu_total ?preu)   
    )
  )
  (if(eq ?stop FALSE)
    then
      (assert (allotjaments-colocats))
    else
      (assert (condicions no_es_poden_complir))
  )
)

(defrule asigna_allotjament22 "no importa la qualitat"
  ?x <- (object(is-a Viatge2))
  (permet-animals ?p_a)
  (preferencia-allotjament-tipus ?p_a_t)
  (not (preferencia-allotjament-qualitat ?))
  (preferencia-lloc ?p_ll)
  (aparcament ?aparc)
  (ciutats-colocades) 
  =>
  (bind ?ciutats (send ?x get-ciutats_visitades))
  (bind ?dies_per_ciutats(send ?x get-dies_per_ciutat))
  (bind ?stop FALSE)
  (loop-for-count (?i 1 (length$ ?ciutats))
    (bind ?c  (nth$ ?i ?ciutats ))
    (bind ?n_c( send ?c get-nom_ciutat))
    (bind ?a_p_c(find-instance((?ins Allotjament))(and(eq ?ins:ciutat_allotjament ?n_c)(eq (determina-parking ?aparc ?ins:te_parking) TRUE)(eq (determina-animals ?p_a ?ins:permet_animals) TRUE)(eq ?ins:tipus_allotjament ?p_a_t)(eq (allotjament_interes ?p_ll ?ins:dist_centre) TRUE))))
    (if(eq (length$ ?a_p_c) 0)
      then 
        (bind ?stop TRUE)
      else
          (slot-insert$ ?x allotjament_per_ciutat ?i ?a_p_c)
          (bind ?preu(send ?x get-preu_total))
          (bind ?prova(send ?x get-allotjament_per_ciutat))
          (bind ?prova1(nth$ ?i ?prova))

          (bind ?dies_per_ciutat(nth$ ?i ?dies_per_ciutats))
          (bind ?preu_allotja(send ?prova1 get-preu_allotjament))
          (bind ?preu (+ ?preu (* ?preu_allotja ?dies_per_ciutat)))
          (send ?x put-preu_total ?preu)   
    )
  )
  (if(eq ?stop FALSE)
    then
      (assert (allotjaments-colocats))
    else
      (assert (condicions no_es_poden_complir))
  )
)

(defrule assigna_allotjament1 "on importa el tipus allotjament i la qualitat " 
    ?x <- (object (is-a Viatge)) 
    (permet-animals ?p_a)
    (preferencia-allotjament-tipus ?p_a_t)
    (preferencia-allotjament-qualitat ?p_a_q)
    (preferencia-lloc ?p_ll)
    (aparcament ?aparc)
    (ciutats-colocades)  
    (dies_assignats)
    =>
    (bind ?ciutats (send ?x get-ciutats_visitades))
    (bind ?dies_per_ciutats(send ?x get-dies_per_ciutat))
    (bind ?stop FALSE)
    (loop-for-count (?i 1 (length$ ?ciutats))
      (bind ?c  (nth$ ?i ?ciutats ))
      (bind ?n_c( send ?c get-nom_ciutat))
      (bind ?apc(find-instance((?ins Allotjament))(and(eq ?ins:ciutat_allotjament ?n_c)(eq (determina-parking ?aparc ?ins:te_parking) TRUE)(eq (determina-animals ?p_a ?ins:permet_animals) TRUE)(eq ?ins:tipus_allotjament ?p_a_t)(eq ?ins:qualitat_allotjament ?p_a_q)(eq (allotjament_interes ?p_ll ?ins:dist_centre) TRUE))))
      (if(< (length$ ?apc) 1)
        then 
          (bind ?stop TRUE)
        else
          (slot-insert$ ?x allotjament_per_ciutat ?i ?apc)
          (bind ?preu(send ?x get-preu_total))
          (bind ?prova(send ?x get-allotjament_per_ciutat))
          (bind ?prova1(nth$ ?i ?prova))

          (bind ?dies_per_ciutat(nth$ ?i ?dies_per_ciutats))
          (bind ?preu_allotja(send ?prova1 get-preu_allotjament))
          (bind ?preu (+ ?preu (* ?preu_allotja ?dies_per_ciutat)))
          (send ?x put-preu_total ?preu)    
      )
    )
    (if(eq ?stop FALSE)
      then
        (assert (allotjaments-colocats))
    else
      (assert (condicions no_es_poden_complir))
    )
  )

(defrule assigna_allotjament12 "on importa el tipus allotjament i la qualitat " 
    ?x <- (object (is-a Viatge2)) 
    (permet-animals ?p_a)
    (preferencia-allotjament-tipus ?p_a_t)
    (preferencia-allotjament-qualitat ?p_a_q)
    (preferencia-lloc ?p_ll)
    (aparcament ?aparc)
    (ciutats-colocades)  
    (dies_assignats)
    =>
    (bind ?ciutats (send ?x get-ciutats_visitades))
    (bind ?dies_per_ciutats(send ?x get-dies_per_ciutat))
    (bind ?stop FALSE)
    (loop-for-count (?i 1 (length$ ?ciutats))
      (bind ?c  (nth$ ?i ?ciutats ))
      (bind ?n_c( send ?c get-nom_ciutat))
      (bind ?apc(find-instance((?ins Allotjament))(and(eq ?ins:ciutat_allotjament ?n_c)(eq (determina-parking ?aparc ?ins:te_parking) TRUE)(eq (determina-animals ?p_a ?ins:permet_animals) TRUE)(eq ?ins:tipus_allotjament ?p_a_t)(eq ?ins:qualitat_allotjament ?p_a_q)(eq (allotjament_interes ?p_ll ?ins:dist_centre) TRUE))))
      (if(< (length$ ?apc) 1)
        then 
          (bind ?stop TRUE)
        else
          (slot-insert$ ?x allotjament_per_ciutat ?i ?apc)
          (bind ?preu(send ?x get-preu_total))
          (bind ?prova(send ?x get-allotjament_per_ciutat))
          (bind ?prova1(nth$ ?i ?prova))

          (bind ?dies_per_ciutat(nth$ ?i ?dies_per_ciutats))
          (bind ?preu_allotja(send ?prova1 get-preu_allotjament))
          (bind ?preu (+ ?preu (* ?preu_allotja ?dies_per_ciutat)))
          (send ?x put-preu_total ?preu)    
      )
    )
    (if(eq ?stop FALSE)
      then
        (assert (allotjaments-colocats))
    else
      (assert (condicions no_es_poden_complir))
    )
  )

(defrule assigna_ciutats1 " assignem les ciutats que visitaran per primer cop "
  ?x <- (object (is-a Viatge))
  ?y <- (object (is-a Viatge2))
  (companyia ?comp)
  (tipus-viatge ?t_viatge)
  (llocs ?site)
  (clima ?clim)
  (preferencia-transport ?prefe)
  (not (preguntat ?))
  =>
  ;;; ?v2 i ?t2 son per poder parametritzar la busqueda i estalviar-nos molts if's
  (if (eq ?prefe vaixell) 
    then
      (bind ?v TRUE)
      (bind ?v2 TRUE)
      (bind ?te FALSE)
      (bind ?te2 TRUE)
    else 
      (bind ?v FALSE)
      (bind ?v2 TRUE)
      (bind ?te2 TRUE)
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
          (bind ?ciut (find-all-instances((?ins Ciutat)) (and(eq ?ins:bona_per_familia TRUE)(or(eq ?ins:te_port ?v2)(eq ?ins:te_port ?v))(or(eq ?ins:te_carretera ?te)(eq ?ins:te_carretera ?te2))(eq (comprova-clima ?clim ?ins:clima)TRUE)( eq ?ins:bona_per_relax TRUE))))
        else  
          (bind ?ciut (find-all-instances((?ins Ciutat)) (and(eq ?ins:bona_per_familia TRUE)(or(eq ?ins:te_port ?v2)(eq ?ins:te_port ?v))(or(eq ?ins:te_carretera ?te)(eq ?ins:te_carretera ?te2))(eq (comprova-clima ?clim ?ins:clima)TRUE))))
      )
      else 
        (if (eq ?t_viatge negoci)
          then 
          (bind ?ciut (find-all-instances((?ins Ciutat)) (and (eq (comprova-clima ?clim ?ins:clima)TRUE)(or(eq ?ins:te_port ?v2)(eq ?ins:te_port ?v))(or(eq ?ins:te_carretera ?te)(eq ?ins:te_carretera ?te2))(eq ?ins:bona_per_negoci TRUE))))
          else 
            (if (eq ?t_viatge relax)
              then 
              (bind ?ciut (find-all-instances((?ins Ciutat)) (and(eq ?ins:bona_per_relax TRUE)(or(eq ?ins:te_port ?v2)(eq ?ins:te_port ?v))(or(eq ?ins:te_carretera ?te)(eq ?ins:te_carretera ?te2))(eq (comprova-clima ?clim ?ins:clima)TRUE))))
              else 
              (bind ?ciut (find-all-instances((?ins Ciutat)) (and(eq (comprova-clima ?clim ?ins:clima)TRUE)(or(eq ?ins:te_port ?v2)(eq ?ins:te_port ?v))(or(eq ?ins:te_carretera ?te)(eq ?ins:te_carretera ?te2)))))
            )
        )
  )
  
  (if (<= ?site (length$ ?ciut))
    then  
      (loop-for-count ( ?i 1 ?site)
        (bind ?d (nth$ ?i ?ciut ))
        (slot-insert$ ?x ciutats_visitades ?i ?d)
      )
      (assert (ciutats-colocades))

      (bind ?iteracione (- (length$ ?ciut) ?site))
      (while (>= (length$ ?ciut) (+ 1 ?iteracione)) do
        (bind ?d (nth$ (+ 1 ?iteracione) ?ciut))
        (slot-insert$ ?y ciutats_visitades 1 ?d)
        (bind ?iteracione (+ 1 ?iteracione))
      )

    else 
      (assert (condicions-ciutat))
  )
)


(defrule assigna_ciutats2 " assignem les ciutats que visitaran quan ja no  "
  ?x <- (object (is-a Viatge))
  ?y <- (object (is-a Viatge2))
  (companyia ?comp)
  (tipus-viatge ?t_viatge)
  (llocs ?site)
  (clima ?clim)
  (preferencia-transport ?prefe)
  (not (finalitzat ?))
  (preguntat ?preg)
  =>
  (assert (finalitzat f))
  ;;; ?v2 i ?t2 son per poder parametritzar la busqueda i estalviar-nos molts if's
  (if (eq ?prefe vaixell) 
    then
      (bind ?v TRUE)
      (bind ?v2 TRUE)
      (bind ?te FALSE)
      (bind ?te2 TRUE)
    else 
      (bind ?v FALSE)
      (bind ?v2 TRUE)
      (bind ?te2 TRUE)
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
          (bind ?ciut (find-all-instances((?ins Ciutat)) (and(eq ?ins:bona_per_familia TRUE)(or(eq ?ins:te_port ?v2)(eq ?ins:te_port ?v))(or(eq ?ins:te_carretera ?te)(eq ?ins:te_carretera ?te2))(eq (comprova-clima ?clim ?ins:clima)TRUE)( eq ?ins:bona_per_relax TRUE))))
        else  
          (bind ?ciut (find-all-instances((?ins Ciutat)) (and(eq ?ins:bona_per_familia TRUE)(or(eq ?ins:te_port ?v2)(eq ?ins:te_port ?v))(or(eq ?ins:te_carretera ?te)(eq ?ins:te_carretera ?te2))(eq (comprova-clima ?clim ?ins:clima)TRUE))))
      )
      else 
        (if (eq ?t_viatge negoci)
          then 
          (bind ?ciut (find-all-instances((?ins Ciutat)) (and (eq (comprova-clima ?clim ?ins:clima)TRUE)(or(eq ?ins:te_port ?v2)(eq ?ins:te_port ?v))(or(eq ?ins:te_carretera ?te)(eq ?ins:te_carretera ?te2))(eq ?ins:bona_per_negoci TRUE))))
          else 
            (if (eq ?t_viatge relax)
              then 
              (bind ?ciut (find-all-instances((?ins Ciutat)) (and(eq ?ins:bona_per_relax TRUE)(or(eq ?ins:te_port ?v2)(eq ?ins:te_port ?v))(or(eq ?ins:te_carretera ?te)(eq ?ins:te_carretera ?te2))(eq (comprova-clima ?clim ?ins:clima)TRUE))))
              else 
              (bind ?ciut (find-all-instances((?ins Ciutat)) (and(eq (comprova-clima ?clim ?ins:clima)TRUE)(or(eq ?ins:te_port ?v2)(eq ?ins:te_port ?v))(or(eq ?ins:te_carretera ?te)(eq ?ins:te_carretera ?te2)))))
            )
        )
  )
  
  (if (<= ?site (length$ ?ciut))
    then  
      (loop-for-count ( ?i 1 ?site)
        (bind ?d (nth$ ?i ?ciut ))
        (slot-insert$ ?x ciutats_visitades ?i ?d)
      )
      (assert (ciutats-colocades))

      (bind ?iteracione (- (length$ ?ciut) ?site))
      (while (>= (length$ ?ciut) (+ 1 ?iteracione)) do
        (bind ?d (nth$ (+ 1 ?iteracione) ?ciut))
        (slot-insert$ ?y ciutats_visitades 1 ?d)
        (bind ?iteracione (+ 1 ?iteracione))
      )

    else 
    (assert (condicions no_es_poden_complir ))
  )
)

;;;**********************
;;;* REGLES ESTÀTIQUES *
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

(defrule preferencia-avio-no-altres ""
  (declare (salience 100))
  (preferencia-transport avio)
  =>
  (assert (peatge-cotxe FALSE))
  (assert (qualitat-vaixell indiferent))
)

(defrule preferencia-cotxe-no-altres
  (declare (salience 100))
  (preferencia-transport cotxe)
  =>
  (assert (qualitat-avio indiferent))
  (assert (qualitat-vaixell indiferent))
)

(defrule preferencia-vaixell-no-altres
  (declare (salience 100))
  (preferencia-transport vaixell)
  =>
  (assert (peatge-cotxe FALSE))
  (assert (qualitat-avio indiferent))
)

(defrule preferencia-autobus-i-tren-no-altres
  (declare (salience 100))
  (or(preferencia-transport autobus)(preferencia-transport tren)(preferencia-transport qualsevol))
  =>
  (assert (qualitat-avio indiferent))
  (assert (peatge-cotxe FALSE))
  (assert (qualitat-vaixell indiferent))
)

(defrule minmax
  (declare (salience 100))
  (presupost baix)
  =>
  (assert (min_press 1))
  (assert (max_press 1000))
)

(defrule minmax2
  (declare (salience 100))
  (presupost mitja)
  =>
  (assert (min_press 1001))
  (assert (max_press 2000))
)

(defrule minmax3 
  (declare (salience 100))
  (presupost alt)
  =>
  (assert (min_press 2001))
  (assert (max_press infinit))
)

;;;***************
;;;* PREGUNTES *
;;;***************

(defrule peatges "Determina si vols passar per peatges amb cotxe"
  (preferencia-transport cotxe)
  (not (peatge-cotxe))
  =>
  (bind ?answer (yes-or-no-p "Vol pagar peatges durant el seu trajecte amb cotxe? (si/no)"))
  (assert (peatge-cotxe ?answer))
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
  (bind ?question "Indiqui quina preferència té de cara al tipus de servei en el vaixell: camarot/butaca/indiferent")
  (bind ?answer (ask-question ?question camarot butaca indiferent))
  (assert (qualitat-vaixell ?answer))
)

(defrule clima "Determina e clima desitjat"
  (not (clima ?))
  =>
  (bind ?question "Indiqui quin tipus de clima desitjaria tenir en la/s ciutat/s que visitarà: tropical/continental/polar/sec/oceanic/mediterrani/indiferent")
  (bind ?answer (ask-question ?question tropical continental polar sec oceanic mediterrani indiferent))
  (assert (clima ?answer))
)

(defrule animals "Determina si el allotjament vols que es permetin animals"
  (not (permet-animals ?))
  =>
  (bind ?question "Voldrà que es permeti l'entrada d'animals domèstics al allotjament on farà estància? (si/no/indiferent)")
  (bind ?answer (ask-question ?question si no indiferent))
  (assert (permet-animals ?answer))
)

(defrule prescindir "Determina si prescindir si sobrepassa el pressupost"
  (or(presupost baix)(presupost mitja))
  (not(prescindir-pressupost ?))
  =>
  (if(yes-or-no-p "En cas que es sobrepassi el seu pressupost però es compleixin totes les altres condicions pel viatge, acceptarà el preu assignat? (si/no)")
    then (assert (prescindir-pressupost si))
    else (assert (prescindir-pressupost no))
  )
)

(defrule ciutats "Determina el nombre de ciutats diferents per les que vol passar"
  (not(preferencia-lloc ?))
  (temps ?temp)
  (not(llocs ?))
  =>
  (bind ?question "Prefereix visitar ciutats/llocs molt turístics o en prefereix d'altres poc coneguts? (turistics/preferiblement-turistics/preferiblement-desconeguts/desconeguts/indiferent)")
  (bind ?answer (ask-question ?question turistics preferiblement-turistics preferiblement-desconeguts desconeguts indiferent))
  (assert(preferencia-lloc ?answer))

  (bind ?question "Indiqui la quantitat de ciutats diferents que vol visitar:")
  (bind ?answer (pregunta-num "Indiqui la quantitat de ciutats diferents que vol visitar:"))
  (bind ?resultat (mes-petit-que ?answer ?temp ?question))
  (assert (llocs ?resultat))
)

(defrule temps "Determina el temps que ha de durar el viatge"
  (not(temps ?))
  =>
   (bind ?answer (pregunta-num "Indiqui la quantitat de dies que vol que duri el viatge: "))
   (assert (temps ?answer))
)

(defrule aparcament "Determina si vols aparcament en el allotjament on aniras"
  (not (aparcament ?))
  =>
  (bind ?question "Vol que el lloc on s'allotjarà tingui parquing? (si/no/indiferent)")
  (bind ?answer (ask-question ?question si no indiferent))
  (assert (aparcament ?answer)) 
)

(defrule qualitat-hotel "Determina preferencies per allotjamnet"
  (not(and(preferencia-allotjament-qualitat ?)(preferencia-allotjament-tipus ?)))
  => 
  (if (yes-or-no-p "Tens alguna preferència de cara al tipus d'allotjament? (si/no)")
    then 
      (bind ?question "Indiqui el tipus d'allotjament desitjat: hotel/apartament/camping")
      (bind ?answer (ask-question ?question hotel apartament camping))
      (assert (preferencia-allotjament-tipus ?answer))  
    (if (yes-or-no-p "Tens alguna preferència de cara a la qualitat allotjament? (si/no)")
      then
        (bind ?question "Indiqui la qualitat desitjada: baixa/estandar/alta/excel·lent")
        (bind ?answer (ask-question ?question baixa estandar alta excel·lent))
        (assert(preferencia-allotjament-qualitat ?answer))
        ;;;si no tenim preferencia de qualitat no la hem ni de crear
    )
    ;;; si no tenim preferencia de tipus allotjament no l'hem ni de crear
  ) 
)


(defrule carnet-conduir "Determina si es te carnet per a conduir"
  (or (preferencia-transport cotxe)(transport-urba cotxe))
  (not(carnet-conduir ?))
  =>
  (if(yes-or-no-p "Tens l'acreditació necessaria per a conduir el transport desitjat? (si/no)")
    then (assert(carnet-conduir si))
    else 
      (assert(carnet-conduir no))
      (assert(problemes "No pots conduir el vehicle desitjat si no tens l'acreditació necessaria"))
  )
)


(defrule cotxe-autonomia "Determina autonomia"
  (preferencia-transport cotxe)
  (not(autonomia-transport ?))
  =>
  (if (yes-or-no-p "Vols que el cotxe sigui llogat? (si/no)")
    then (assert(autonomia-transport cotxe-no))
    else (assert(autonomia-transport cotxe-yes))
  )
)

(defrule transport-pel-lloc "determina com moure's per el lloc"
  (not (transport-local ?))
  =>
  (bind ?question "Indiqui amb quin tipus de transport es vol mobilitzar per la ciutat: autobus/metro/tren/cotxe/indiferent")
  (bind ?answer (ask-question ?question autobus metro tren cotxe indiferent))
  (assert(transport-urba ?answer))
)

(defrule preferencies-transport "determina la preferencia en el transport"
  (not(preferencia-transport ?))
  =>
  (if (yes-or-no-p "Hi ha alguna preferencia de transport per desplaçar-se entre destins?(si/no)")
    then 
      (bind ?question "Indiqui quin es el transport que prefereix fer servir: avio/vaixell/tren/cotxe/autobus")
      (bind ?answer (ask-question ?question avio vaixell tren cotxe autobus))
      (assert(preferencia-transport ?answer))
    else (assert(preferencia-transport qualsevol))
  )
)

(defrule determina-presupost "Preguntem sobre el presupost"
  (not(presupost ?))
  =>
  (bind ?question "Quin es el presupost per persona per a tot el viatge? (baix(200-1000€) / mitja(1001-2000€) / alt(+2001€))")
  (bind ?answer (ask-question ?question baix mitja alt))
  (assert(presupost ?answer))
)


(defrule  determina-tipus "determinem el tipus de viatge"
  (not (tipus-viatge ?))
  =>
  (bind ?question "Com volen orientar el seu viatge? (cultural/relax/aventurer/festa/indiferent)")
  (bind ?answer (ask-question ?question cultural relax aventurer festa indiferent))
  (assert(tipus-viatge ?answer))
  (if (eq ?answer aventurer)
    then (assert (tipus-viatge activitat))
  )
)


(defrule determina-tipus2 "determinem el tipus per una persona sola"
  (companyia sol)
  (not(tipus-viatge ?)) 
  =>
  (bind ?question "Com vol orientar el seu viatge? (negoci/cultural/relaxat/aventurer/indiferent)")
  (bind ?answer (ask-question ?question negoci cultural relaxat aventurer indiferent))
  (assert(tipus-viatge ?answer))
)


(defrule determina-atoritzacio "Determinem si tenen autorització o no"
  (or(edat petits)(infants si))
  (not(autoritzacio ?))
  =>
  (if (yes-or-no-p "Tens/teniu autorització d'un parent o tutor per a fer aquest viatge? (si/no)")
    then (assert (autoritzacio si))
    else (assert (autoritzacio no))
        (assert(problemes "No et podem personalitzar cap viatge. Abans necessites l'autorització d'un parent o tutor"))
  )
)

(defrule deremina-edat2 "Determina si hi ha persones grans"
  (companyia familia)
  =>
  (if (yes-or-no-p "Viatjaran persones grans amb la família? (si/no)")
    then (assert(edat totes))
    else (assert(edat no-avis))
  )
)

(defrule determina-menors "ens assegurem si hi ha o no menors d'edat al grup"
  (not(or(companyia familia)(companyia sol)))
  (not (infants ?))
  =>
  (if (yes-or-no-p "Hi ha algun menor d'edat al grup? (si/no)")
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


(defrule det-companyia "Analitzem amb quin tipus de companyia farà el viatge"
  (not (companyia ?))
  =>
  (if(yes-or-no-p "Viatges sol? (si/no)")
    then (assert(companyia sol))
    else
      (bind ?question "Amb quina companyia viatges? (familia/amics/parella/altre)")
      (bind ?comp (ask-question ?question familia amics parella altre))
      (assert(companyia ?comp))   
  )
)

(defrule Problemaedat ""
  (declare (salience 10))
  (edat petits)
  =>
  (assert(problemes "Ho sentim, No podem personalitzar viatges a menors d'edat. Ho ha de fer un major d'edat."))
)

(defrule determina-edat2 "edat"
  (nom ?)
  (not (and(edat ?)(edat-num ?)))
  =>
  (bind ?answer (pregunta-num "Quina es la seva edat?"))
  (assert (edat-num ?answer))
  (franga-edat ?answer)
)

(defrule nombre "Pregunta el nom"
  (not(nom ?))
  =>
  (printout t "Quin es el teu nom? " crlf)
  (bind ?nom1 (read))
  (assert(nom ?nom1))
)


;;;*********************************************
;;;**FI PREGUNTES I MOSTRAR VIATGES RECOMANATS**
;;;*********************************************

(defrule sistema-viatges ""
  (declare (salience 100))
  =>
  (printout t crlf crlf)
  (printout t "*****************************************************************"crlf)
  (printout t "               Agència de viatges FI DEL MON" crlf "      Sistema de personalització de viatges per a majors d'edat."crlf)
  (printout t "*****************************************************************"crlf)
  (printout t crlf crlf))

(defrule Print-problema ""
  (declare (salience 100))
  (problemes ?item)
  =>
  (printout t crlf crlf)
  (format t " %s%n%n%n" ?item)
  (halt)
)

;;; Crea el template consejo con la solucion
(defrule solucion-domestico
 (declare (salience -1))
 ?x <- (object (is-a Viatge))
 ?y <- (object (is-a Viatge2))
 =>
 (assert (consell (TRIP ?x) (TRIP2 ?y)))
)

(deffunction lista-ciudades (?ciud ?trans ?inter ?allotj ?dpc)
 (bind ?principi 1)
 (bind ?final 0)
 (bind ?t (nth$ 1 ?trans))
  (loop-for-count (?i 1 (length$ ?ciud))
     (bind ?c (nth$ ?i ?ciud))
     (bind ?dcs (nth$ ?i ?dpc))
     (bind ?dc (* ?dcs 2))
     (bind ?a (nth$ ?i ?allotj))

     (send ?c imprime)    ;;imprimeix la ciutat
     (printout t "            S'han assignat " ?dcs " dies per a visitar aquesta ciutat." crlf crlf)
     (send ?t imprime)
     (printout t crlf)
     (send ?a imprime)
     (printout t crlf)

     (printout t "            Per a aquesta ciutat s'han planejat les següents visites:" crlf)
     (loop-for-count (?j ?principi (+ ?final ?dc))
        (send (nth$ ?j ?inter) imprime)
     )

     (printout t crlf)
     (bind ?final (+ ?final ?dc))
     (bind ?principi (+ ?principi ?dc))
     (printout t crlf crlf) 
  )

  (printout t "         Finalment, el últim destí és casa seva:" crlf)
  (send (nth$ (length$ ?trans) ?trans) imprime)
)

(deffunction lista-ciudades2 (?ciud ?trans ?inter ?allotj ?dpc)
 (bind ?principi 1)
 (bind ?final 0)
 (bind ?t (nth$ 1 ?trans))
  (loop-for-count (?i 1 (length$ ?ciud))
     (bind ?c (nth$ ?i ?ciud))
     (bind ?dcs (nth$ ?i ?dpc))
     (bind ?a (nth$ ?i ?allotj))

     (send ?c imprime)    ;;imprimeix la ciutat
     (printout t "            S'han assignat " ?dcs " dies per a visitar aquesta ciutat." crlf crlf)
     (send ?t imprime)
     (printout t crlf)
     (send ?a imprime)
     (printout t crlf)

     (printout t "            Per a aquesta ciutat s'han planejat les següents visites:" crlf)
     (bind ?ciut_act (send ?c get-nom_ciutat))
     (loop-for-count (?k 1 (length$ ?inter))
      (bind ?ci (nth$ ?k ?inter))
      (bind ?ciutinter (send ?ci get-ciutat))
      (if (eq ?ciutinter ?ciut_act)
        then
          (send (nth$ ?k ?inter) imprime)
      )
     )
    
     (printout t crlf crlf crlf) 
  )

  (printout t "         Finalment, el últim destí és casa seva:" crlf)
  (send (nth$ (length$ ?trans) ?trans) imprime)
)

(defmessage-handler Viatge imprime primary ()
  (bind ?totaldies 0)
  (loop-for-count (?i 1 (length$ ?self:ciutats_visitades))
    (bind ?elque (nth$ ?i ?self:dies_per_ciutat))

    (bind ?totaldies (+ ?totaldies ?elque))
  )

  (printout t "   · Tindrà una durada de: " ?totaldies " dies" crlf crlf)
  (printout t "   · El preu total per persona:" ?self:preu_total "€" crlf crlf)
  (printout t "   · Es visitaran un total de " (length$ ?self:ciutats_visitades) " ciutats diferents:" crlf crlf)
 ;; (imprime-tot ?self:llocs_interes_per_dia)
  ;;(imprime-tot ?self:transport_viatge)
  ;;(imprime-tot ?self:ciutats_visitades)
  ;;(imprime-tot ?self:allotjament_per_ciutat)
  (lista-ciudades ?self:ciutats_visitades ?self:transport_viatge ?self:llocs_interes_per_dia ?self:allotjament_per_ciutat ?self:dies_per_ciutat)
  
  ;(printout t (length$ ?self:ciutats_visitades))
)

(defmessage-handler Viatge imprime2 primary ()
  (bind ?totaldies 0)
  (loop-for-count (?i 1 (length$ ?self:ciutats_visitades))
    (bind ?elque (nth$ ?i ?self:dies_per_ciutat))

    (bind ?totaldies (+ ?totaldies ?elque))
  )

  (printout t "   · Tindrà una durada de: " ?totaldies " dies" crlf crlf)
  (printout t "   · El preu total per persona:" ?self:preu_total "€" crlf crlf)
  (printout t "   · Es visitaran un total de " (length$ ?self:ciutats_visitades) " ciutats diferents:" crlf crlf)
  ;;(imprime-tot ?self:llocs_interes_per_dia)
  ;;(imprime-tot ?self:transport_viatge)
  ;;(imprime-tot ?self:ciutats_visitades)
  (lista-ciudades2 ?self:ciutats_visitades ?self:transport_viatge ?self:llocs_interes_per_dia ?self:allotjament_per_ciutat ?self:dies_per_ciutat)
  
  ;(printout t (length$ ?self:ciutats_visitades))
)

(defmessage-handler Viatge2 imprime primary ()
  (bind ?totaldies 0)
  (loop-for-count (?i 1 (length$ ?self:ciutats_visitades))
    (bind ?elque (nth$ ?i ?self:dies_per_ciutat))

    (bind ?totaldies (+ ?totaldies ?elque))
  )

  (printout t "   · Tindrà una durada de: " ?totaldies " dies" crlf crlf)
  (printout t "   · El preu total per persona:" ?self:preu_total "€" crlf crlf)
  (printout t "   · Es visitaran un total de " (length$ ?self:ciutats_visitades) " ciutats diferents:" crlf crlf)
 ;; (imprime-tot ?self:llocs_interes_per_dia)
  ;;(imprime-tot ?self:transport_viatge)
  ;;(imprime-tot ?self:ciutats_visitades)
  ;;(imprime-tot ?self:allotjament_per_ciutat)
  (lista-ciudades ?self:ciutats_visitades ?self:transport_viatge ?self:llocs_interes_per_dia ?self:allotjament_per_ciutat ?self:dies_per_ciutat)
  
  ;(printout t (length$ ?self:ciutats_visitades))
)

(defmessage-handler Viatge2 imprime2 primary ()
  (bind ?totaldies 0)
  (loop-for-count (?i 1 (length$ ?self:ciutats_visitades))
    (bind ?elque (nth$ ?i ?self:dies_per_ciutat))

    (bind ?totaldies (+ ?totaldies ?elque))
  )

  (printout t "   · Tindrà una durada de: " ?totaldies " dies" crlf crlf)
  (printout t "   · El preu total per persona:" ?self:preu_total "€" crlf crlf)
  (printout t "   · Es visitaran un total de " (length$ ?self:ciutats_visitades) " ciutats diferents:" crlf crlf)
  ;;(imprime-tot ?self:llocs_interes_per_dia)
  ;;(imprime-tot ?self:transport_viatge)
  ;;(imprime-tot ?self:ciutats_visitades)
  (lista-ciudades2 ?self:ciutats_visitades ?self:transport_viatge ?self:llocs_interes_per_dia ?self:allotjament_per_ciutat ?self:dies_per_ciutat)
  
  ;(printout t (length$ ?self:ciutats_visitades))
)

(defmessage-handler Ciutat imprime primary ()
  (printout t "        - " ?self:nom_ciutat ":" crlf)
  (printout t "            El clima d'aquesta ciutat és " ?self:clima crlf)
)

(defmessage-handler Allotjament imprime primary ()
  (printout t "            S'allotjara en un " ?self:tipus_allotjament)
  (printout t " anomenat " ?self:nom_allotjament ":" crlf)
  (printout t "                 + Es troba una una distància de " ?self:dist_centre "km del centre de la ciutat." crlf)

  (bind ?b (send ?self get-permet_animals))
      (if (eq ?b TRUE)
        then
        (printout t "                 + Està permesa l'endrada d'animals domèstics." crlf)
      else
        (printout t "                 + No està permesa l'endrada d'animals domèstics." crlf)
      )

  (bind ?tl (send ?self get-tipus_allotjament))
  (if (eq ?tl hotel)
    then
      (printout t "                 + Disopsa de wifi gratis i servei d'habitacions."crlf)
      (printout t "                 + Disposa de servei de menjador, no inclos en el preu de l'habitació." crlf)
    else
      (if (eq ?tl apartament)
        then
          (printout t "                 + Disposa de wifi gratis i esmorzar cada dia, inclos en el preu de l'habitació." crlf)
          (printout t "                 + No disposa de servei d'habitacions, respectem la seva intimitat i el seu ordre. El personal netejarà quan deixi l'habitació." crlf)
        else
          (printout t "                 + Disposa d'esmorzar i berenar, inclos en el preu de l'habitació." crlf)
          (printout t "                 + Vostè es trobarà en la natura, així que tot el que siguin serveis electrònics innecessaris no estaràn disponibles." crlf)
      )
  )
  

  (bind ?b (send ?self get-te_parking))
      (if (eq ?b TRUE)
        then
        (printout t "                 + Disposa de plaça de parking." crlf)
      else
        (printout t "                 + No disposa de plaça de parking." crlf)
      )

  (printout t "                 + El preu per dia per persona és de " ?self:preu_allotjament "€." crlf)
)

(defmessage-handler Llocs_interes imprime primary()
  (printout t "                 + " ?self:nom_lloc)

  (bind ?p (send ?self get-preu_lloc_int))
      (if (> ?p 0)
        then 
          (printout t " amb un preu de " ?p "€." crlf)
        else 
          (printout t " ; GRATUIT" crlf)
      )
)

(defmessage-handler Transport imprime primary() 
  (printout t "            El transport assignat per arribar a la ciutat destí és un " ?self:tipus_transport "." crlf)

  (bind ?q (send ?self get-qualitat_transport))
  (if (eq ?q bo)
    then
      (printout t "                + El transport assignat és de bona qualitat." crlf)
    else 
      (if (eq ?q mitja)
        then 
          (printout t "                + El transport assignat té una qualitat estàndard." crlf)
        else 
          (printout t "                + El transport assignat no és de bona qualitat." crlf)
      )
  )

  (bind ?t (send ?self get-tipus_transport))
    (if (eq ?t cotxe)
      then 
        (printout t "                + El cotxe que es farà servir serà " ?self:nom_transport "."crlf)
        (bind ?peat (send ?self get-peatge))
          (if (eq ?peat TRUE)
            then
              (printout t "                + Es seguira una ruta pagant peatges."crlf)
            else 
              (printout t "                + Es seguirà una ruta sense pagar peatges." crlf)
          )
    )

    (if (eq ?t vaixell)
      then
        (printout t "                + El vaixell pertany a la companyia " ?self:nom_transport "." crlf)
        (bind ?cam (send ?self get-camarot))
        (if (eq ?cam TRUE)
          then
            (printout t "                + Disposarà de camarot per passar la estància al vaixell." crlf)
          else
            (printout t "                + Disposarà de butaca per passar la estància al vaixell." crlf)
        )
    )

    (if (eq ?t avio)
      then
        (printout t "                + L'avió pertany a la companyia " ?self:nom_transport "." crlf)
        (bind ?pref (send ?self get-preferent))
        (if (eq ?pref TRUE)
          then
            (printout t "                + El seu seient es troba en la classe preferent (VIP)." crlf)
          else 
            (printout t "                + El seu seient es troba en la classe turística (NO VIP)." crlf)
        )
    )

    (printout t "                + Disposa d'una capacitat màxima de " ?self:max_pers " persones."crlf)
)

(defrule rectifica-per-ciutat "cambiem parametres per determinar les ciutats"
 (condicions-ciutat)
 (not (preguntat ?))
 (tipus-viatge ?t_viatge)
 (companyia ?comp)
 (preferencia-transport ?p_t)
 (clima ?c)
 (llocs ?ll)
 (nom ?name)
  =>
  (assert (preguntat p))
  (printout t "---------------------------------" ?c crlf)
  (printout t "Benvolgut/da " ?name "," crlf crlf "No s'han trobat totes les ciutats amb les condicions que ha indicat. " crlf)
  (if (eq ?t_viatge negoci)
    then
      (bind ?tam(length$ (find-all-instances(( ?ins Ciutat))(and(eq (comprova-clima ?c ?ins:clima)TRUE)(eq ?ins:bona_per_negoci TRUE)))))
    else
      (if (eq ?t_viatge festa)
        then
          (bind ?tam(length$ (find-all-instances(( ?ins Ciutat))(and(eq (comprova-clima ?c ?ins:clima)TRUE)(eq ?ins:bona_per_festa TRUE)))))
        else
          (if (eq ?t_viatge relax)
            then
              (if(eq ?comp familia)
                then    (bind ?tam(length$ (find-all-instances(( ?ins Ciutat))(and(eq (comprova-clima ?c ?ins:clima)TRUE)(eq ?ins:bona_per_familia TRUE)(eq ?ins:bona_per_relax TRUE)))))
                else    (bind ?tam(length$ (find-all-instances(( ?ins Ciutat))(and(eq (comprova-clima ?c ?ins:clima)TRUE)(eq ?ins:bona_per_familia TRUE)(eq ?ins:bona_per_relax TRUE)))))
              )
            else              
             (if(eq ?comp familia)
                then    (bind ?tam(length$ (find-all-instances(( ?ins Ciutat))(and(eq (comprova-clima ?c ?ins:clima)TRUE)(eq ?ins:bona_per_familia TRUE)))))
                else    (bind ?tam(length$ (find-all-instances(( ?ins Ciutat))(eq (comprova-clima ?c ?ins:clima)TRUE))))
              )
          )
      )
  )
  (if (eq ?tam 0)
    then 
      (printout t crlf crlf "no tenim cap ciutat que amb el clima escollit siui adecuada per la seva companyia i el seu interes del viatge" crlf )
      (bind ?question "Voldra cambiar el clima? (yes/no) Recordi que si no ho fa no li podrem personalitzar el viatge" clfr)
      (if(yes-or-no-p ?question)
        then
          (bind ?question "Indiqui quin tipus de clima desitjaria tenir en la/s ciutat/s que visitarà: tropical/continental/polar/sec/oceanic/mediterrani/indiferent")
          (bind ?answer (ask-question ?question tropical continental polar sec oceanic mediterrani indiferent))
          (bind ?c ?answer)
          (assert (clima ?answer))
        else
          (printout t  crlf "HO SENTIM MOLT PERÒ NO LI PODEM PERSONALITZAR EL VIATGE" crlf)
          (halt)
      )
    else
      (if (> ?ll ?tam)
        then
          (printout t "El numero de ciutats amb el clima indicat i les condicions per la seva companyia, i intencions del viatge són: " ?tam  crlf )
          (bind ?question "Voldras canviar el clima o bé el nombre de ciutats a visitar? (clima/nombre)")
          (bind ?answer(ask-question ?question clima nombre))
          (if(eq ?answer clima)
            then
              (bind ?question "Indiqui quin tipus de clima desitjaria tenir en la/s ciutat/s que visitarà: tropical/continental/polar/sec/oceanic/mediterrani/indiferent")
              (bind ?answer (ask-question ?question tropical continental polar sec oceanic mediterrani indiferent))
              (bind ?c ?answer)
              (assert (clima ?answer))
            else          
              (bind ?question "Indiqui la quantitat de ciutats diferents que vol visitar:")
              (bind ?answer (pregunta-num "Indiqui la quantitat de ciutats diferents que vol visitar:"))
              (bind ?resultat (mes-petit-que ?answer ?tam ?question))
              (assert (llocs ?resultat))
          )
        else 
          (printout t crlf crlf "Per a que li poguem personalitzar el viatge amb les condicions que ha establert haura de cambiar el transport" crlf)
          (bind ?question "Indiqui quin es el transport que prefereix fer servir: avio/vaixell/tren/cotxe/autobus")
          (bind ?answer (ask-question ?question avio vaixell tren cotxe autobus))
          (assert(preferencia-transport ?answer))
      )
  )
)


(defrule resultado-consejo "Regla salida de consejo"
 (declare (salience 10))
 (consell (TRIP ?r))
 (consell (TRIP2 ?tash))
 (nom ?name)
 (not (llocs_insuficients))
 (not (condicions no_es_poden_complir))
  =>
  (printout t "------------------------------------------------------------------------------------------------------" crlf)
  (printout t "Benvolgut/da " ?name "," crlf crlf "Els dos viatges que millor s'adapten a les seves necessitats són: " crlf)
  (printout t crlf "Primer viatge:" crlf)
  (send ?r imprime)
  (printout t crlf)
  (printout t crlf "Segon viatge:" crlf)
  (send ?tash imprime)
  (printout t crlf)
  (halt)
)

(defrule resultado-consejo2 "Regla salida de consejo"
 (declare (salience 10))
 (condicions no_es_poden_complir)
 (nom ?name)
  =>
  (printout t "------------------------------------------------------------------------------------------------------" crlf)
  (printout t "Benvolgut/da " ?name "," crlf crlf "No s'ha trobat cap viatge amb les condicions que ha indicat, si us plau, torni-ho a provar. " crlf)
  (halt)
)

(defrule resultado-consejo3 "Regla salida de consejo"
 (declare (salience 10))
 (consell (TRIP ?r))
 (consell (TRIP2 ?tash))
 (llocs_insuficients)
 (not (condicions no_es_poden_complir))
 (nom ?name)
  =>
  (printout t "------------------------------------------------------------------------------------------------------" crlf)
  (printout t "Benvolgut/da " ?name "," crlf crlf "S'han trobat dos viatges que s'aproximen a les seves necessitats: " crlf)
  (printout t crlf "Primer viatge:" crlf)
  (send ?r imprime2)
  (printout t crlf)
  (printout t crlf "Segon viatge:" crlf)
  (send ?tash imprime2)
  (printout t crlf)
  (halt)
)