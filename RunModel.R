
setwd("~/GitHub/ABM_Hilltopping/")

#to make sure it is the right place you should do session then set up working directory
directory = getwd()
outdir    = paste(directory,"/output/", sep="")
source(paste(directory, "/source/FunctionSourcer.R", sep =''))

#parameters
elevation.V = c(0, 400)           #peak elevation min and max
landscape.V = 150                 #number of patches on each side, total patch number = landscape*landscape, this was given
numind.V    = 50                  #number of individuals to simulate
nsteps.V    = 500                 #number of steps an individual can take, this was given 
move.V      = 0.8                 #decimal likelihood of individual moving to highest neighbor patch (R&G call this q)
reps        = 2                   #number of replicates to run 

parameters = expand.grid(elevation.V,landscape.V,nindvs.V,nsteps.V,move.V) #this creates a data frame for all of these parameters
colnames(parameters) = c("elevation","landscape","numind","nsteps","move")
parameters = parameters[parameters$elevation!=0,] #what is this for ?


for(p in 1:nrow(parameters)){
  elevation = c(0, parameters$elevation[p])
  landscape = parameters$landscape[p]
  numind    = parameters$nindvs[p]
  nsteps    = parameters$nsteps[p]
  move      = parameters$move[p]
  
  for(r in 1:reps){
    #initialize landscape
    land = LandscapeInit(elevation, landscape)
    image(land)
    
    #the way Janna did it
    pdf(paste(directory, "/output/butterflypath_", r, ".pdf", sep=""), width = 8, height = 8)
    #this will save it directly to the pdf
    
    
    #initialize individuals on landscape
    pop = NPop(nindvs, landscape)
    points(pop[,1]/150, pop[,2]/150, pch=21, cex=0.5)
    #pop = rbind(pop,NewPop(nindv,landscape)) #this will add the different NewPops together
    #plot(-100,-100, xlim=c(0,150), ylim=c(0,150))  #this puts the points on its own figure (note 0-150 axes)
    #points(pop[,1], pop[,2], pch=19, cex=0.5) #puts points on own fig
    
    
    #allow individuals to move within landscape
    pathways = NULL
    for(i in 1:nrow(pop)){
      #isolate individual of interest
      indv = pop[i,,drop=FALSE]
      #the i means iterates
      
      #chart movement
      movepath = MoveIndv(numind, land, move, nsteps, elevation, landscape)
      
      #plot movement
      lines(movepath[seq(1,length(movepath), 2)]/150, movepath[seq(2,length(movepath), 2)]/150, lwd=2)
      
      #record path in single object for all individuals
      pathways = rbind(pathways, movepath)
      
    }
    rownames(pathways) = seq(1,nindvs,1)
    dev.copy(png, "../output/Butter.png") #saves it to the source folder that you had everything, albeit adding 'output' saves it in the output folder
    dev.off() #need to add this if not it will not save, if you do the pdf code at the top and close it off then you can open it and see even through the steps. 
    
    #extract needed output from simulation
    #for this project it is fine to NOT do any stats, but you will want to export something (maybe a figure) so you and
    #everyone can see how your model worked. we will use this to talk about approaches that worked well/did not work great.
    
  } 
}

#traceback() , allows you to traceback the error so you can find where it is and fix it :)


