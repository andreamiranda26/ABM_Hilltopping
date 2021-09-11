## **ABM Butterfly Hilltopping**





*Simple model assignment for ABM course in Auburn University Fall 2021*

Butterfly dispersal and hilltopping

When individuals disperse they often use corridors, which we tend to think of as linear features on the landscape. However, corridors can also be present in patterns we don't expect. These so-called virtual corridors can appear when landscape features that appear unimportant to us influence individual behavior. In many butterfly species, individuals move uphill to congregate and find mates, a behavior called hill topping. We will use the hill topping model concept of Pe'er et al. (2005)* to explore this phenomenon in butterflies, using a simple agent based model we will write in R.

**Model overview**

Purpose: The model will be to explore questions about virtual corridors. Under what conditions do the interactions of butterfly hillgopping behavior and landscape topography lead to the emergence of virtual corridors? (We will define these as narrow paths along which many butterflies move.) 

Entities, state variables, and scales: The model has two entities: butterflies and square patches of land. The total landscape is comprised of 150x150 patches, and each patches has one state variable (elevation).  Butterflies are characterized by their location on the landscape. (We will describe butterflies by combinations of X and Y coordinates.) Simulations last for 500 time steps and each step is the time it takes for a butterfly to move through one patch.

Process overview: The basic principle addressed by this model is the concept of virtual corridors. This concept is addressed by seeing when corridors emerge from two parts of the mode: the adaptive movement behavior and the landscape they move through. This adaptive behavior is modeled via a simple empirical rule that reproduces the behavior observed in real life: moving uphill. Sensing is important in the model. We assume butterflies can identify which nearby patch has the highest elevation. Stochasticity is used to represent variability in movement that are too complex to represent mechanistically. 

Initialization: The topography of the landscape is initialized when the model starts. We will use an artificial topography. The butterflies are initialized by creating 500 of them and setting their initial location to a single patch.

Input Data: There is no input data.

Subroutine: The movement subroutine defines exactly how butterflies decide whether to move uphill or randomly. This function first says to move to a neighbor patch that has the heist election. If two or more are the same, the butterfly moves randomly. Neighbor patches are the eight patches that share an edge with the occupied patch. The decision to move uphill or randomly is controlled by a parameter that ranges from 0-1 and reflects the probability of moving uphill. If a random draw for a focal individual is greater than the variable set for the simulation, the individual moves uphill. Otherwise, it moves randomly.

*This idea is straight out of Railsback and Grimm, with a couple modifications implemented here.

**Assignment details**

The model has the following general steps:

A script is set up for finding saved functions, outputs, and needed libraries, including working and output This includes setting your working and output directories and sourcing your scripts.
Parameters needed to run model are defined. Each parameter has a comment describing what that variable controls and (if needed) the range of values the parameter can take. 
Landscape is initialized. This is done with a function that returns a landscape of variable size patches. Each patch should has an assigned elevation and a single peak. The elevation roughly decreases from the peak point, with some variance allowed.
Individuals are initialized and moved on the landscape. Each individual is be randomly assigned a starting location, defined by an X and Y coordinate.
Individuals are moved up to a specified number of steps. Movement at each step will is based on the probability of it moving to a higher elevation patch or moving randomly to an adjacent patch, and this is controlled by a function. Once the individual reaches the peak area of the landscape, it does not leave the peak. Hint: for some coders, it may be simpler to iterate over individuals. This isn't the most efficient way to run the model but will help you learn how to code and run so is completely fine for this project.
Needed information is extracted from simulation. We wanted to know if cryptic corridors emerge from this simulation. Typically, we would address this statistically, but since this is meant to be an illustrative example it is shown this graphically in the code. 
**Cryptic corridors did appear in most cases. The code to extract the graph showing the corridors after each loop is found in RunModel.** 
