package IA.ProbRESCATS;

import aima.search.framework.GoalTest;

public class ProbRESCATSGoalTest implements GoalTest {
	
	public boolean isGoalState(Object aState) {
	    return(false);
	  }
	
}

/*AL TSP reeimplementen la funció retornant sempre fals, en canvi
al de les monedes fan una funció que determina si es l'objectiu,
suposu que ho fan perque aquí treballem directament en un estat de solucions*/