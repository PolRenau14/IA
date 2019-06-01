package IA.ProbRESCATS;

import aima.search.framework.HeuristicFunction;
import IA.Desastres.*;
import java.math.*;
import java.util.Random; 

public class ProbRESCATSHeuristicFunction implements HeuristicFunction {


	public double getHeuristicValue(Object state){

		ProbRESCATSBoard board = (ProbRESCATSBoard)state;


		double temps = 0;
		//double penalitza=0; //Forma part del heuristic 2.
		for (int h=0; h<board.getSize(); ++h) {
			Centro c = ProbRESCATSBoard.C.get(ProbRESCATSBoard.centheli[h]);

			int cx = c.getCoordX();
			int cy = c.getCoordY();

			int nombre_rescats_amb_grups = 0;
			for( int r = 0; r < board.getSizeR(h); ++r ) {
				double dist = 0;
				int x = cx;
				int y = cy;
				if (board.Rescat_Amb_Grup(h, r)) {++nombre_rescats_amb_grups;}
				//boolean prio = false; forma part del heurístic 2
				for( int g = 0; g < 3; ++g) {
					int uax = r*3+g;

					if( board.getSolution().get(h).get(uax) != -1) {
						Grupo gru = ProbRESCATSBoard.G.get(board.getSolution().get(h).get(uax));


						int gx = gru.getCoordX();
						int gy = gru.getCoordY();
						dist = Math.sqrt((gx - x) * (gx - x) + (gy - y) * (gy - y));
						temps += dist/1.6666666666;  //el temps ha d'estar en minuts


						if (gru.getPrioridad() == 1) {temps += gru.getNPersonas()*2;
							//penalitza += temps; prio =true; Forma part del heurístic 2
							}
						else temps += gru.getNPersonas();

						x = gx;
						y = gy;
					}
				}
				//if (prio) penalitza += temps; forma part de heurístic
				dist = Math.sqrt((x-cx)*(x-cx) + (y-cy)*(y-cy));

				temps += dist/1.6666666666;
			}
			temps += 10*(nombre_rescats_amb_grups-1);
		}
		//double heuristic = penalitza*16+ temps;
		double heuristic = temps;
		((ProbRESCATSBoard) state).temps=temps;
		return (heuristic);

	}

}