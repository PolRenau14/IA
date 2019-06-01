import IA.ProbRESCATS.*;
import IA.Desastres.*;
import aima.search.framework.Problem;
import aima.search.informed.HillClimbingSearch;
import aima.search.framework.Search;
import aima.search.framework.SearchAgent;
import aima.search.informed.SimulatedAnnealingSearch;

import java.util.*;


public class Main {
    public static void main(String[] args) {

        Scanner scanner = new Scanner(System.in);
        System.out.println("Introdueixi el nombre de centres dels que disposa per al rescat:");
        Integer ncentres = scanner.nextInt();

        System.out.println("Introdueixi el nombre d'helicopter que vol per a cada centre:");
        Integer nhelicopters = scanner.nextInt();

        System.out.println("Introdueixi el seed:");
        Integer nseedh =scanner.nextInt();

        Centros C = new Centros(ncentres, nhelicopters, nseedh);            //Afegim els par�metres manualment

        System.out.println("Introdueixi el nombre de grups que cal rescatar:");
        Integer ngrups = scanner.nextInt();

        System.out.println("Introdueixi el seed:");
        Integer nseedg =scanner.nextInt();

        Grupos G = new Grupos(ngrups, nseedg);

        System.out.println("Indiquins si vol trobar la solució amb el algorisme Hill Climbing escrivint H o amb el Simulated Aleaning escrivint S");
        char algorisme = scanner.next().charAt(0);
        System.out.println("introdueixi generacio estat inicial, 1 -> greedy, 2-> ordered, 3->random");
        int cas = scanner.nextInt();

        ProbRESCATSBoard board = new ProbRESCATSBoard(C, G, cas);
        ProbRESCATSBoard newboard = new ProbRESCATSBoard();
        long TempsInici = System.nanoTime();
        if (algorisme == 'H') {
            RescatsHillClimbingSearch(board, newboard);
        } else if (algorisme == 'S') {
            RescatsSimulatedAnnealingSearch(board);
        } else {
            System.out.println("No has indicicat el algorisme qamb el que vols treballar correctament.");
        }
        long TempsFinal = System.nanoTime();
        long TempsTotal = TempsFinal - TempsInici;
        double nano = Math.pow(10, -9);
        System.out.println(TempsTotal * nano);

    }

    private static void RescatsHillClimbingSearch(ProbRESCATSBoard board, ProbRESCATSBoard newboard) {

        try {
            Problem problem = new Problem(board, new ProbRESCATSSuccesorFunction(2), new ProbRESCATSGoalTest(), new ProbRESCATSHeuristicFunction());
            Search search = new HillClimbingSearch();
            SearchAgent agent = new SearchAgent(problem, search);
            printActions(agent.getActions());
            printInstrumentation(agent.getInstrumentation());
            newboard = (ProbRESCATSBoard)search.getGoalState();
            System.out.println(newboard.temps);
            newboard.pinta();
        } catch (Exception var4) {
            var4.printStackTrace();
        }

    }

    private static void RescatsSimulatedAnnealingSearch(ProbRESCATSBoard board) {

        try {
            Problem problem = new Problem(board, new ProbRESCATSSuccesorFunctionSA(), new ProbRESCATSGoalTest(), new ProbRESCATSHeuristicFunction());
            Search search = new SimulatedAnnealingSearch(150000, 1000, 80, 0.00006);
            SearchAgent agent = new SearchAgent(problem, search);
            //printActionsSA(agent.getActions());
            printInstrumentation(agent.getInstrumentation());
            ProbRESCATSBoard newboard = (ProbRESCATSBoard)search.getGoalState();
            newboard.pinta();
            System.out.println(newboard.temps);
        } catch (Exception var4) {
            var4.printStackTrace();
        }

    }

    private static void printInstrumentation(Properties properties) {
        Iterator keys = properties.keySet().iterator();

        while(keys.hasNext()) {
            String key = (String)keys.next();
            String property = properties.getProperty(key);
            System.out.println(key + " : " + property);
        }

    }

    private static void printActions(List actions) {
        for(int i = 0; i < actions.size(); ++i) {
            if( i < actions.size()) {
                String action = (String) actions.get(i);
                System.out.println(action+ actions.size());
            }
        }

    }



    private static void printtot(ProbRESCATSBoard b) {
        ArrayList<ArrayList<Integer>> s = b.getSolution();
        for( int i = 0; i< b.getSize();++i) {
            System.out.print("Estic en el helicopter: " +i);
            for ( int j = 0; j < b.getSizeR(i)*3;++j) {
                System.out.print(" " + s.get(i).get(j));
            }
            System.out.println();
        }
    }



}