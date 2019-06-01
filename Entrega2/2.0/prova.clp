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

;;;**********************
;;;* ENGINE STATE RULES *
;;;**********************

(defrule auto ""
  (declare (salience 100))
  (or (edat joves)(edat grans)(edat adults))
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

;;;***************
;;;* QUERY RULES *
;;;***************


(defrule prescindir "Determina si prescindir si sobrepassa el pressupost"
  (or(pressupost baix)(pressupost mitja))
  (not(prescindir ?))
  =>
  (if(yes-or-no-p "En cas que es sobrepassi el seu pressupost, voldrà prescindir d'alguna de les prefrencies indicades previament? (yes/no=acceptara el pressupost)")
    then (assert (prescindir si))
    else (assert (prescindir no))
  )
)

(defrule ciutats "Determina el nombre de ciutats diferents per les que vol passar"
  (not(preferencia-lloc ?))
  (not(llocs ?))
  =>
  (if (yes-or-no-p "Prefereix visitar ciutats/llocs molt turístics o en prefereix d'altres poc coneguts? (yes=turístics/no=poc coneguts)")
    then (assert(preferencia-lloc coneguts))
    else (assert(preferencia-lloc desconeguts))
  )
  (printout t "Indiqui la quantitat de llocs diferents que vol visitar" crlf "(recordi que se li assignaràn una quantitat de dies a cada lloc en funció del que ofereixin i dels dies que hagui indicat que vol passar de viatge)" crlf ": ")
  (bind ?city (read))
  (assert (llocs ?city))
)

(defrule temps "Determina el temps que ha de durar el viatge"
  (not(temps ?))
  =>
   (printout t "Indiqui la quantitat de dies que vol que duri el viatge: ")
   (bind ?dies (read))
   (assert (temps ?dies))
)

(defrule qualitat-hotel "Determina preferencies per allotjamnet"
  (not(preferencia-allotjament ?))
  => 
  (if (yes-or-no-p "Tens alguna preferència de cara a la qualitat allotjament? (yes/no)")
    then
      (printout t "Indiqui la qualitat desitjada:" crlf "(baixa/estandar/alta/excel·lent)")
      (bind ?qualitat (read))
      (assert(preferencia-allotjament ?qualitat))
    else (assert(preferencia-allotjament qualitat-no))
  )
  (if (yes-or-no-p "Tens alguna preferència de cara al tipus d'allotjament? (yes/no)")
    then 
      (printout t "Indiqui el tipus d'allotjament desitjat:" crlf "(hotel/apartament/airbnb/altres)")
      (bind ?lloc (read))
      (assert (preferencia-allotjament ?lloc))
    else (assert(preferencia-allotjament lloc-no))
  )
)


(defrule carnet-conduir "Determina si es te carnet per a conduir"
  (or(preferencia-transport coche)(autonomia-transport bus-llogat)(autonomia-transport bus-yes))
  (not(carnet-conduir ?))
  =>
  (if(yes-or-no-p "Tens l'acreditació necessaria per a conduir el transport desitjat? (yes/no)")
    then (assert(carnet-conduir si))
    else 
      (assert(carnet-conduir no))
      (assert(problemes "No pots conduir el vehicle desitjat si no tens l'acreditació necessaria"))
  )
)

(defrule autobus-autonomia "Determina autonomia"
  (preferencia-transport autobus)
  (not(autonomia-transport ?))
  =>
  (if (yes-or-no-p "Vols que el autobus sigui llogat? (yes/no)")
    then (assert(autonomia-transport bus-llogat))
    else 
      (if (yes-or-no-p "Vols comprar un ticket per autobus? (yes/no) Si no el vols comprar suposarem que  vol conduïr un propi autobus")
        then (assert(autonomia-transport bus-ticket))
        else (assert(autonomia-transport bus-yes))
      )
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


(defrule preferencies-transport "determina la preferencia en el transport"
  ;;;(not(tipus escolar))
  (not(preferencia-transport ?))
  =>
  (if (yes-or-no-p "Hi ha alguna preferencia en quant a transport es refereix?(yes/no)")
    then 
      (printout t "Indiqui quin es el transport que prefereix fer servir:" crlf "(avio/vaixell/tren/coche/autobus)")
      (bind ?prefer (read))
      (if (or (eq ?prefer avio)(eq ?prefer vaixell)(eq ?prefer tren)(eq ?prefer coche)(eq ?prefer autobus))
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


(defrule  determina-tipus "determinem el tipus de viatge"
 ;;; (or(companyia familia)(companyia amics)(companyia altres)(companyia ;;;parella))
  (not (tipus-viatge ?))
  =>
  (printout t "Com volen orientar el seu viatge? crlf (cultural/relaxat/aventurer/escolar/altre)")
  (bind ?tip (read))
  (if (or (eq ?tip cultural)(eq ?tip escolar)(eq ?tip relaxat)(eq ?tip aventurer)(eq ?tip altre))
    then (assert(tipus-viatge ?tip))
  )
)


(defrule determina-tipus2 "determinem el tipus per una persona sola"
  (companyia sol)
  (not(tipus-viatge ?)) 
  =>
  (printout t "Com vol orientar el seu viatge? crlf (negoci/cultural/relaxat/aventurer/altre)")
  (bind ?tip (read))
  (if (or (eq ?tip negoci)(eq ?tip cultural)(eq ?tip relaxat)(eq ?tip aventurer)(eq ?tip altre))
    then (assert(tipus-viatge ?tip))
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

(defrule deremina-edat2 "Determina si hi ha persones grans"
  (companyia familia)
  (not(edat ?))
  =>
  (if (yes-or-no-p "Viatjaran persones grans amb la família? (yes/no)")
    then (assert(edat totes))
    else (assert(edat no-avis))
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


(defrule determina-persones "Definim el tamany del grup"
  (or (companyia familia)(companyia amics)(companyia altres))
  (not(tamany ?))
  (not(tipus-tamany ?))
  =>
  (printout t "Quantes persones viatjareu? (indiqui amb nombres)")
  (bind ?quantitat (read))
  (assert (tamany ?quantitat))
  (if(>= ?quantitat 10)
    then (assert(tipus-tamany gran))
    else
      (if (>= ?quantitat 5)
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
      (printout t "Amb quina companyia viatges? (familia/amics/parella/altre)" crlf)
      (bind ?comp (read))
      (if (or (eq ?comp familia)(eq ?comp amics)(eq ?comp parella)(eq ?comp altre))
        then (assert(companyia ?comp))
      )
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