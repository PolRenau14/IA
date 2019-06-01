package IA.ProbRESCATS;
import IA.Desastres.*;
import org.omg.CORBA.PRIVATE_MEMBER;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Random;
import java.util.SimpleTimeZone;

/*Classe que contindra la representaccio d'estat (solucio) del problema
 a mes de la definicio dels operadors*/

public class ProbRESCATSBoard {

	private ArrayList<ArrayList< Integer > > Solution;
	static int[] centheli;
	static Centros C;
	static Grupos G;
	public double temps;
public ProbRESCATSBoard() {}

	public ProbRESCATSBoard(ArrayList<ArrayList< Integer > > s, int size) {
		//Solution = s;
		Solution = new ArrayList<ArrayList<Integer>>();
		for(int i=0; i<size; ++i) {
			ArrayList<Integer> aux = new ArrayList<Integer>();
			for(int j=0; j<s.get(i).size(); ++j){
				aux.add(s.get(i).get(j));
			}
			Solution.add(aux);
		}
	}
	public ProbRESCATSBoard(ArrayList<ArrayList< Integer> > s) {
		Solution = s;
	}

	private int bonCentre(int i , int j) {
		double mindist = 85493;
		int minc=0;
		for(int c = 0; c < C.size();++c) {
			double aux= Math.sqrt((i - C.get(c).getCoordX()) * (i - C.get(c).getCoordX()) + (j - C.get(c).getCoordY()) * (j - C.get(c).getCoordY()));
			if( aux < mindist){
				mindist =aux;
				minc =c;
			}
		}
		return minc;
	}
	private int[] bonRescat(int num_centre,Grupo g) {
		int[] aux = new int[2];
		int helicent = C.get(num_centre).getNHelicopteros();
		aux[0] = -1; aux[1] = num_centre*helicent;
		double mindist=731489;
		for( int h = num_centre*helicent; h< num_centre*helicent+helicent;++h) {
			//System.out.println(Solution.get(h).size());
			for(int r = 0; r < Solution.get(h).size()/3;++r) {
				int np=0;
				int x =C.get(h).getCoordX();
				int y =C.get(h).getCoordY();
				boolean bona =false;int pr;
				for(pr=0; pr < 3 && !bona; ++pr) {
					if(Solution.get(h).get(r*3+pr) != -1) {
						Grupo ga = G.get(Solution.get(h).get(r*3+pr));
						np += ga.getNPersonas();
						x = ga.getCoordX();
						y = ga.getCoordY();
					}
					else {
						if( np +g.getNPersonas() < 16) bona =true;
					}
				}
				if(bona) {
					double dist = Math.sqrt((x - g.getCoordX()) * (x - g.getCoordX()) + (y - g.getCoordY()) * (y - g.getCoordY()));

					if (dist < mindist) {
						mindist = dist;
						aux[0] = r * 3 + pr-1;
						aux[1] = h;
					}
				}
			}
		}
		return aux;
	}

	public ProbRESCATSBoard(Centros C,  Grupos G,int cas){
		ProbRESCATSBoard.C = C;
		ProbRESCATSBoard.G = G;

		int nhelicopteros_total = 0;
		for (int i=0; i<C.size(); ++i) {
			nhelicopteros_total+= C.get(i).getNHelicopteros();
		}
		ProbRESCATSBoard.centheli = new int[nhelicopteros_total];
		Solution = new ArrayList< ArrayList<Integer > >();

		switch (cas) {
			case 1: {
				for(int i = 0; i< nhelicopteros_total;++i) {
					ArrayList<Integer> inner = new ArrayList<Integer>();
					for(int j = 0; j < 3;++j) inner.add(j,-1);
					Solution.add(i,inner);
				}

				for(int g = 0; g < G.size();++g) {
					int c = bonCentre(G.get(g).getCoordX(),G.get(g).getCoordY());
					int[] aux = bonRescat(c,G.get(g));
					int r = aux[0];
					int h = aux[1];
					if(r== -1) {
						Solution.get(h).add(g);
						for(int i = 0;i< 2;++i) Solution.get(h).add(-1);
					}

					else Solution.get(h).set(r,g);

				}
				break;
			}
			case 2: {
				int ii = 0;
				for( int hh = 0; hh < nhelicopteros_total;  ++hh) {
					ArrayList<Integer> inner = new ArrayList<Integer>();
					int ux = G.size()/nhelicopteros_total;
					for(int rr = 0; rr < (G.size()/nhelicopteros_total)+1; ++rr) {
						int cg = 0;
						for ( int i = 0; i < 3 ; ++i) {
							if ( i <2 ) {
								if (ii < ProbRESCATSBoard.G.size()) {
									Grupo g = ProbRESCATSBoard.G.get(ii);
									cg += g.getNPersonas();
									if (cg < 16) {
										inner.add(rr * 3 + i, ii); // afegirem 3 grups per rescat com a maxim.

										++ii;
										int aux = rr * 3 + i;
									}
									else inner.add(rr * 3 + i, -1);
								}
								else inner.add(rr*3+i,-1);
							}
							else inner.add(rr*3+i,-1);
						}
					}
					Solution.add(hh,inner);
				}
				break;
			}
			case 3: {
				for(int i = 0; i< nhelicopteros_total;++i) {
					ArrayList<Integer> inner = new ArrayList<Integer>();
					for(int j = 0; j < 3;++j) inner.add(j,-1);
					Solution.add(i,inner);
				}

				Random myRandom = new Random();
				for(int g = 0; g < G.size();++g) {
					int c = myRandom.nextInt(C.size());
					int[] aux = bonRescat(c,G.get(g));
					int r = aux[0];
					int h = aux[1];
					if(r== -1) {
						Solution.get(h).add(g);
						for(int i = 0;i< 2;++i) Solution.get(h).add(-1);
					}

					else Solution.get(h).set(r,g);

				}
				break;
			}
			default: {
				System.out.println("Cas mal introduït");
				break;
			}
		}

		int nh =0;
		for (int iii=0; iii<C.size(); ++iii) {
			for( int f = 0; f < C.get(iii).getNHelicopteros();++f) {
				if( nh < centheli.length) {
					ProbRESCATSBoard.centheli[nh] = iii;
					++nh;
				}
			}
		}
	}


	public boolean tegrups(int h,int r) {
		for(int i = 0; i < 3; ++i ) if( Solution.get(h).get(r*3 +i) != -1) return true;
		return false;
	}
	public void pinta() {
		ArrayList<ArrayList<Integer>> s = Solution;
		for( int i = 0; i< this.getSize();++i) {
			System.out.print("Estic en el helicopter: " +i);
			int k = 0;
			for ( int j = 0; j < this.getSizeR(i)*3;++j) {
				if( j%3 == 0 && this.tegrups(i,j/3)) {
					System.out.println();
					System.out.print("Rescat numero: " + k + " -->");
					++k;
				}
				if(s.get(i).get(j) != -1) {
					String st ="";
					if(G.get(s.get(i).get(j)).getPrioridad() == 1 ) st = "PRI-";
					System.out.print(" " +st+ s.get(i).get(j));
				}
			}
			System.out.println();
			System.out.println();
		}
	}
	public int getSize() { return Solution.size();}
	public int getSizeR(int h) {
		//if ( h >= this.getSize())return 0;
		return Solution.get(h).size()/3;

	}

	static int[] getCH() {return ProbRESCATSBoard.centheli;}

	static Centros getCentros() { return ProbRESCATSBoard.C;}

	static Grupos getGrupos() { return ProbRESCATSBoard.G;}

	public boolean Rescat_Amb_Grup(int h, int r) {
		if(Solution.get(h).get(r*3) != -1) return true;
		if(Solution.get(h).get(r*3 + 1) != -1) return true;
		if(Solution.get(h).get(r*3 + 2) != -1) return true;
		return false;
	}

	public boolean Helicopter_Amb_Rescat(int h) {
		for (int r = 0; r < this.getSizeR(h); ++r) {
			if(this.Rescat_Amb_Grup(h, r)) return true;
		}
		return false;
	}

	public ArrayList<ArrayList<Integer > > getSolution() {return this.Solution;}

	int compleix(int np,int h, int r) {
		int cont = 0;
		int aux = -1;
		for( int i = 0; i <3; ++i ) {
			if(r*3+i < this.getSizeR(h)) {
				if (Solution.get(h).get(r * 3 + i) != -1) {
					cont += G.get(Solution.get(h).get(r *3 + i)).getNPersonas();
					if (cont + np >= 16) return -1;
				}
				else aux = i;
			}
		}
		if (cont +np < 16 && aux != -1 ) return 3*r+aux;
		else return -1;

	}

	public void canviGrup(int posg,int h1, int h2, int r2, int posg2) {

		if( Solution.get(h1).get(posg) != -1 && Solution.get(h1).get(posg) < G.size() && Solution.get(h2).get(posg2) == -1) {
			Grupo gru = G.get(Solution.get(h1).get(posg));
			;
			int npers = gru.getNPersonas();
			for(int i=0; i<3; ++i) {
				if (Solution.get(h2).get(r2*3+i) != -1) npers+=G.get(Solution.get(h2).get(r2*3+i)).getNPersonas();
			}
			if (npers <=15) {
				Solution.get(h2).set(posg2, Solution.get(h1).get(posg));
				Solution.get(h1).set(posg, -1);
			}

		}
	}

	public void swap (int h1, int h2, int posg1, int posg2) {
		//if (Solution.get(h1).get(posg1) != -1 && Solution.get(h2).get(posg1) != -1) {
		int aux = Solution.get(h1).get(posg1);
		Solution.get(h1).set(posg1, Solution.get(h2).get(posg2));
		Solution.get(h2).set(posg2, aux);
		int npers1=0;

		int r1 = posg1/3;
		r1 = r1*3;
		for(int i=0; i<3; ++i){
			if (Solution.get(h1).get(r1+i) != -1) {
				npers1 += G.get(Solution.get(h1).get(r1+i)).getNPersonas();
			}
		}

		int npers2=0;

		int r2 = posg2/3;
		r2 = r2*3;
		for(int i=0; i<3; ++i){
			if (Solution.get(h2).get(r2+i) != -1) {
				npers2 += G.get(Solution.get(h2).get(r2+i)).getNPersonas();
			}
		}

		if (npers1 >= 15  || npers2 >= 15) {
			aux = Solution.get(h1).get(posg1);
			Solution.get(h1).set(posg1, Solution.get(h2).get(posg2));
			Solution.get(h2).set(posg2, aux);
		}
	}

	public void swap (int h1, int h2, int r1, int r2,boolean t) {
		for( int i = 0; i< 3; ++i) {
			int aux = Solution.get(h1).get(r1*3+i);
			Solution.get(h1).set(r1*3+i,Solution.get(h2).get(r2*3+i));
			Solution.get(h2).set(r2*3+i,aux);
		}
	}




}