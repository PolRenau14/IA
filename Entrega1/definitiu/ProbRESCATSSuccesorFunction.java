package IA.ProbRESCATS;

import aima.search.framework.SuccessorFunction;
import aima.search.framework.Successor;
import java.util.ArrayList;
import java.util.List;

public class ProbRESCATSSuccesorFunction implements SuccessorFunction {

	public int c;

	public ProbRESCATSSuccesorFunction(int c) {
		this.c = c;
	}

	public List<Successor> getSuccessors(Object state) {
		ArrayList<Successor> retVal = new ArrayList<Successor>();
		ProbRESCATSBoard board = (ProbRESCATSBoard)state;
		ProbRESCATSHeuristicFunction RESCATSHF  = new ProbRESCATSHeuristicFunction();

		/*Aqui ve el codi amb el que generarem els nous estats que anirem
		 * afegint a retVal (Que es el que finalment retornarem)
		 */
		double ini_v = RESCATSHF.getHeuristicValue(board);
		switch (this.c) {
			case (1): {
				for(int h1=0; h1<board.getSize();++h1) { 
					for(int r1=0; r1<board.getSizeR(h1); ++r1) {
						for( int g = 0; g< 3; ++g) {
							if(board.getSolution().get(h1).get(r1*3+g) != -1) {
								for (int h2 = 0; h2 < board.getSize(); ++h2) {
									for (int r2 = 0; r2 < board.getSizeR(h2); ++r2) {
										if (h2 != h1 || r2 != r1) {
											for(int k = 0; k< 3; ++k) {
												ProbRESCATSBoard newBoard = new ProbRESCATSBoard(board.getSolution(), board.getSize());
												int uax = r1 * 3 + g;
												newBoard.canviGrup(uax, h1, h2, r2, r2 * 3 + k);
												double v = RESCATSHF.getHeuristicValue(newBoard);
												String S = "canvi de helicopter " + h1 + " rescat " + r1 + " a helicopter " + h2 + " rescat " + r2 + " Cost: " + v;
												retVal.add(new Successor(S, newBoard));
											}
										}
									}
								}
							}
						}
					}
				}
				break;

			}
			case (2) : {
				for(int h1=0; h1<board.getSize(); ++h1) {
					for(int pos_h1=0; pos_h1<board.getSizeR(h1)*3; ++pos_h1) {
						for(int h2=h1; h2<board.getSize(); ++h2) {
							for(int pos_h2=0; pos_h2<board.getSizeR(h2)*3; ++pos_h2) {
								if( board.getSolution().get(h1).get(pos_h1) != -1 || board.getSolution().get(h2).get(pos_h2) != -1) {
									ProbRESCATSBoard newBoard = new ProbRESCATSBoard(board.getSolution(), board.getSize());
									newBoard.swap(h1, h2, pos_h1, pos_h2);
									double v = RESCATSHF.getHeuristicValue(newBoard);
									String S = "Ha fet un swap------------" + v;
									retVal.add(new Successor(S, newBoard));
								}
							}
						}
					}
				}
				break;
			}
			case (3): {
				for(int h1=0; h1< board.getSize();++h1) {
					for(int r1 = 0; r1 < board.getSizeR(h1);++r1) {
						for(int h2 = h1; h2< board.getSize();++h2) {
							for(int r2= 0; r2 < board.getSizeR(h2);++r2) {
								ProbRESCATSBoard newBoard = new ProbRESCATSBoard(board.getSolution(), board.getSize());
								newBoard.swap(h1, h2, r1, r2,true);
								double v = RESCATSHF.getHeuristicValue(newBoard);
								String S = "Ha fet un swap rescat------------" + v;
								retVal.add(new Successor(S, newBoard));
							}

						}
					}
				}
				break;
			}
			default : {
				System.out.println("Has introduit malament el heuristic.");
				break;
			}
		}

		return retVal;
	}

}