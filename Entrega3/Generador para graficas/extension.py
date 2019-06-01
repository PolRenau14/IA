import random
contador = 1
while (contador < 10) :
	contAux = 4
	while( contAux <= (contador*4)):
		min_dies_c = random.randint(1,3)
		max_dies_c = random.randint(3,6)

		min_dies_t = 1#int(input('Numweo minim de dies total \n'))

		file = open("problema"+str(contador*4)+"-"+str(contAux)+".pddl","w")

		file.write("(define (problem viatges) (:domain trobaviatges)\n(:objects\n")
		count = 0
		num_ciutats = contador*4
		ciuts = []

		#INICIALITZACIO DELS OBJECTES
		while count <= num_ciutats:
			file.write(" C%d" %(count))
			ciuts.append(count)
			count +=1
		file.write(" - ciutat\n ")
		#per fer un minim de ciutats entre tots els valors possibles de ciutat.
		min_num_ciutats = contAux

		maxim = max_dies_c * min_num_ciutats
		minim = min_dies_c * min_num_ciutats
		min_dies_t = random.randint(minim,maxim)	
		num_total_allotj = []
		count = 1
		while count <= num_ciutats:
			cont_h = 1
			num_allotjaments = random.randint(1,3)
			x=0
			while x < num_allotjaments: 
				x+=1

			n = x
			num_total_allotj.append(n)  
			while cont_h <= num_allotjaments:
				file.write("A%d-%d " %(count,cont_h))
				cont_h +=1
			count+=1

		file.write("- hotel\n ")

		volsDescripcio= []
		count = 0
		while count <= num_ciutats:
		
			i=0
			aux =[]
			while  i < len(ciuts):
				aux.append(i)
				i+=1
		
			print(len(ciuts))
			maxVols = random.randint(1,3)
			count2=1
			while count2 <= maxVols:
				v = random.choice(aux)
				aux.remove(v)
				if count == v:
					v=random.choice(aux)
					aux.remove(v)
				if count != v:
					paraulAuxiliar2 = "(Vuelode V"+str(count)+"-"+str(v)+" C"+str(count)+" C"+str(v)+")\n"
					volsDescripcio.append(paraulAuxiliar2)
					file.write("V%d-%d " %(count,v))
				count2+=1
			count+=1

		file.write("- vol\n)\n\n(:init\n")

		# FI INICIALITZACIO DE OBJECTES

		count = 1
		while count <= num_ciutats:
			cont_h = 1
			num_allotjaments = num_total_allotj[count-1]
			while cont_h <= num_allotjaments:
				file.write(" (Allotjamentde A%d-%d C%d)\n" %(count,cont_h,count))
				cont_h+=1
			count+=1

		count = 0
		while count < len(volsDescripcio):
			file.write(volsDescripcio[count])
			count +=1


		count = 1
		while count <= num_ciutats:
			file.write(" (= (diesperciutat C%d)0)" %(count))
			count += 1

		file.write(" (= (visitades) 0)\n (= (minim-ciu) %d)\n" %(min_num_ciutats))
		file.write(" (= (minim-d-c) %d)\n (= (maxim-d-c) %d)\n (= (minim-d) %d)\n" %(min_dies_c, max_dies_c, min_dies_t))
		file.write(" (= (diastotal) 0)\n(= (interestotal) 0)\n")



		count = 1
		while count <= num_ciutats:
			interes_ciut = random.randint(1, 3)
			file.write(" (= (interes C%d) %d)\n" %(count, interes_ciut))
			count +=1

		file.write(" (en C0)\n)\n")

		file.write(" (:goal (and\n  (>= (visitades) (minim-ciu))\n  (>= (diastotal) (minim-d))\n  (en C0)\n)\n)\n")
		file.write(" (:metric minimize (interestotal))\n)")
		file.close()
		contAux += 4
	contador += 1

	#a = input() llegeix de la linia de comandos
	#print(a)
 	#file2.append(line)   #append serveix per escriure al final del fitxer

	
