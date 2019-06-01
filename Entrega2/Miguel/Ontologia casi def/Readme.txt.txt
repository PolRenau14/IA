En referencia a la ontologia: 

Canvis respecte la ontologia inicial: 
	- El tipus d'un lloc turístic passa a ser multivalue
	- Al transport, s'afegeix l'atribut tipus, que es un symbol amb (avio, vaixell, autocar, cotxe, tren)

Respecte a la instanciació: 
	- Estan afegides un total de 15 ciutats
	- Cada ciutat disposa de 4 allotjaments que seran: 
		- 2 hotels (un car i un barat)
		- 1 apartament
		- 1 camping * (no el tenen totes, només algunes ciutats)
	- Cada ciutat té de 6 a 8 llocs d'interés, on s'intenta que es puguin incloure el maxim tipus de lloc possible.
	- Existeixen 10 instancies de transport, on s'intenta variar la qualitat així com el preu. 

IMPORTANT: Al preu per km del transport he intentat que siguin valors raonables, pero tot i així no sé com es comportaran
 	   amb el programa, per tant pot ser que més endavant els haguem de canviar. 

A la carpeta hi és també un arxiu .clp que conté la funció que s'ha d'incloure al programa que retorna un float amb la distancia
entre dos punts passant-li per paràmetre: latitud1 longitud1 latitud2 longitud2 dels punts a calcular. 