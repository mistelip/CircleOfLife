# MATLAB Spring 2014 – Research Plan
> * Group Name: Children Of Scar
> * Group participants names: Kaelin Ruben, Misteli Patrick
> * Project Title: Circle Of Life

## General Introduction
In the movie "the Lion King" we get a glimps of what they refer to as the "circle of life". This is a simplified model of how nature keeps its animals alive even though there exists a food chain. "The Antilopes get eaten by the Lions, which become Grass once they die, which will be eaten once again by the antilopes"
We want to see how "easy" it is for nature to keep the balance between predator and prey. With simple variable (explained in the Model section below) we want to see how much each variable affects this balance. The model should demonstrate that even though there exists a food hierarchy in nature, all animals will still be able to live. 
A further interesting aspects would be to do what the character "Scar" did in the movie mentioned above. He did not respect the animals below him which (nearly) let to the distinction of all animals (even the Lions themselves) 

## The Model
A good starting point model is Conway's Game of Life with slight modifications. The result will look similar to a Kermack-McKendrick model.

Instead of having simple Cells that can either be Dead or alive we introduce A further dimension. The 3rd dimension will be used for the following variables.

    int type            //The type encoded as a number ("Lion", "Antilope", "Grass" or "Nothing")
	int predatorType	//The type of the predator
	int becomesID	    //What type does this organism become after death
    
    int foodDigest		//Food digested in a day
	int stomach		    //Subtract "foodDigest" each day, +1 when eating, when equal to 0 organism becomes "becomesID"
    int maxStomach      //Organism will not feed if it's stomach reaches this constant
	int lifespan	    //-1 after each turn, when reaching 0 organism becomes "becomeID"
	int fatness	        //How many organisms can be fed by this organism
    int minStomachRepInd //How "full" the organism has to be to be able to reproduce

    
Updating Rules:
As in game of life we look at the 8-neighbourhood. We adapt the rules to our model:

Updating organism field:
	If neighbourhood includes pray
        --> Remove 1 from fatness of the pray
        --> Mark pray so it will be dead at the end of the round
        --> Add +1 to stomach
    
Updating "Nothing" field:  
	1: If neignbourhood includes two organisms of the same kind with both (stomach > MinFoodToRep)
        --> Change the "Nothing" field to the organism type
		--> If there are multiple potential pairs
			--> Randomly choose one
		--> The variables of the new organism contain either default values or depend on the variables of the parents 
        
Additions: Probability that organism can successfully eat pray/ Reproduce.

Limits due to abstraction:
    It lacks the ability for organisms to travel and "look" for a potental mate. 
    An organism is able to reproduce from the first day it is born. 

## Fundamental Questions
Does our model end up with a balance or does one organism overtake the land?
Which parameters affect the balance the most?
Is it necessary to have a food chain?
    What if we remove the Lions or the Lions and the Antilopes?
    What if organisms do NOT eat each other?


## Expected Results
In theory the result should be similar to the Lotka-Volterra equations. Using the parameters we can alter the species and create a super-organism which should wipe out the land and eventually die of starvation. 

Setting a low foodDigest (meaning the organism requires little food to live) will result in a steady number of this species, given that not many predators are around
    
Setting a high minStomachRepInd will result in a low reproduction of this species and they will eventually die out if the lifespan is not long enough.

Setting a high fatness will allow mutliple predators to eat from this organism in a turn, which results in a long life for predators. 

We require both rules, as rule 1 prevents the land from getting over populated. This could also be the result when animals do not eat each other.
Rule 2 prevents organisms from dying out. If they cannot reproduce their numbers will only fall.
    


## References 
Kermack-McKendrick model
Slides from 3. March

## Research Methods
Cellular Automata

## Other
We will generate random and manual landscapes to test our model.
