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