package IA.ProbRESCATS;

import aima.search.framework.Successor;
import aima.search.framework.SuccessorFunction;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

public class ProbRESCATSSuccesorFunctionSA implements SuccessorFunction{
    public ProbRESCATSSuccesorFunctionSA(){
    }

    public List<Successor> getSuccessors(Object state) {
        ArrayList<Successor> retVal = new ArrayList<Successor>();
        ProbRESCATSBoard board = (ProbRESCATSBoard)state;
        ProbRESCATSHeuristicFunction RESCATSHF  = new ProbRESCATSHeuristicFunction();
        Random myRandom = new Random();

        //introduim el helicopter 1 del qual volem canviar un grup
        int h1;

        //evidentment l'helicopter ha de tenir algun rescat amb algun grup per a poder fer el canvi
        do {
            h1 = myRandom.nextInt(board.getSize());
        } while (!board.Helicopter_Amb_Rescat(h1));

        //helicopter amb el qual farem el canvi. No es importa si aquest te els rescats buits
        int h2 = myRandom.nextInt(board.getSize());
        int r2;

        //El grup que volem canviar ha de pertanyer a un rescat no buit del helicopter 1
        //do {
            r2 = myRandom.nextInt(board.getSizeR(h2)*3);
        //}while(!board.Rescat_Amb_Grup(h2, r2));

        int pos_grup;

        //trobem un grup entre els 3 que hi ha al rescat que no estigui buit
        do {
            pos_grup = myRandom.nextInt(board.getSolution().get(h1).size());
            //pos_grup = pos_grup + (r2*3);
        } while(board.getSolution().get(h1).get(pos_grup) == -1 && board.getSolution().get(h2).get(r2) == -1 );

        ProbRESCATSBoard newBoard = new ProbRESCATSBoard(board.getSolution(), board.getSize());
        //newBoard.canviGrup(pos_grup, h1, h2, r2);
        newBoard.swap(h1,h2,pos_grup,r2);
        double v = RESCATSHF.getHeuristicValue(newBoard);
        String S = "canvi de " + h1 + " " + r2 + " a " + h2 + " Cost: " + v;
        retVal.add(new Successor(S, newBoard));
        return retVal;
    }
}