%{
TODO: 
    Label Axes
    Line Chart for Counter
    Death by age vs hunger
    

    Report:
        Question in Intro
        Answer in Conclusion
    
    Possible Question:
        Why sequential update, not random?

    (Random Seed store)
%}

% Simulate Circle Of life

%------CONSTANTS---------------------------------

TIMESTEPS = 1000;
NUMBER_OF_SPECIES = 3;



% 0 = Nothing
% 1 = Grass
% 2 = Antilope
% 3 = Lion
NUMBER_OF_VARIABLES = 12;
SETUPINDEX = 3;
LAND_NUMBER = 1;

typeInd = 1;
preyTypeInd = 2;    %The type of the prey
becomesInd = 3; %What type does this organism become after death

foodDigestInd = 4;   %Food digested in a day
stomachInd = 5; %Subtract "foodDigest" each day, +1 when eating, when equal to 0 organism becomes "becomesID"
maxStomachInd = 6;  %Organism will not feed if it's stomach reaches this constant

deathProbInd = 7;    %-1 after each turn, when reaching 0 organism becomes "becomeID"
fatnessInd = 8; %How many organisms can be fed by this organism
aliveInd = 9; %1 if alive, 0 if bitten
minStomachRepInd = 10; %minimum stomach required to reproduce;
repProbInd = 11;    %Probability of Reproduction
isOffspring = 12;    %0 = Cannot Reproduce?

NOTHING =   typeToOrganism(0,SETUPINDEX);
GRASS =     typeToOrganism(1,SETUPINDEX);
ANTILOPE =  typeToOrganism(2,SETUPINDEX);
LION =      typeToOrganism(3,SETUPINDEX);

%---------------------------------------------------


[X,Y,organismMat,organismCountMat] = getLand(LAND_NUMBER,NUMBER_OF_VARIABLES,SETUPINDEX);
deathCauseMat = zeros(3,3);

%Initialize Video Writer
%fig = figure;
vidObj = VideoWriter('sample.avi');
vidObj.Quality= 100;
%vidObj.FrameRate= 2;
open(vidObj);


%Print initial Land
printLand(organismMat(:,:,1),organismCountMat(1,:),1,deathCauseMat);


disp('Initial Land Printed, 1 sec before start');
pause(1);


% Define the Moore neighborhood, i.e. the 8 nearest neighbors
neigh = [-1 -1; 0 -1; 1 -1; 1 0; 1 1; 0 1; -1 1; -1 0];

% main loop, iterating the time variable, t

for t=1:TIMESTEPS    
    %Add lions after t timesteps
    %{ 
    if t == 50
        for i=1:X
            for j=1:Y
                if i > 20 && i < 25 &&...
                        j >= 20 && j <= 25
                    organismMat(i,j,:) = LION;
    
                end
            end
        end 
    end
    %}
    

  
    allEmpty = 1;
    
    deathlist = ones(X*Y,2);
    deathlistIndex = 0;
    offspringList = ones(X*Y,2);
    offspringListIndex = 0;
    organismCounter = organismCountMat(t,:);
    
    %Adjust stomach -> vectorized for performance
    organismMat(:,:,stomachInd) = organismMat(:,:,stomachInd) - organismMat(:,:,foodDigestInd);
    for i=1:X
        for j=1:Y
            organismMat(i,j,stomachInd) = organismMat(i,j,stomachInd) - organismMat(i,j,foodDigestInd);
            currentAnimal = organismMat(i,j,:);
            
            if (currentAnimal(aliveInd) == 0)
                continue; %Animal is dead and is on deathlist
            end
            
            if currentAnimal(typeInd) ~= NOTHING(typeInd)
                % Still Alive? (Age & Hunger)-----------------------------------
                allEmpty = 0;
                iDie = 0;
                
                if (currentAnimal(stomachInd) < 0)
                    %Died of hunger
                    iDie = 1;
                    deathCauseMat(currentAnimal(typeInd),1) = deathCauseMat(currentAnimal(typeInd),1) + 1;
                end
                
                if (currentAnimal(deathProbInd) > rand)
                    %Died of Age
                    iDie = 1;
                    deathCauseMat(currentAnimal(typeInd),2) = deathCauseMat(currentAnimal(typeInd),2) + 1;
                end
                if (iDie == 1)
                    organismCounter(currentAnimal(typeInd)) = organismCounter(currentAnimal(typeInd)) -1;
                    newType = currentAnimal(becomesInd);
                    if (newType > 0)
                        organismCounter(newType) = organismCounter(newType) + 1;
                    end
                    newOrganism = typeToOrganism(newType,SETUPINDEX);
                    organismMat(i,j,:) = newOrganism;
                    continue;
                end
                
                %Check Neighborhood                
                %Organism
                potentialMatingLocaction = [-1,-1];
                potentialMate = [-1,-1];
                matingOnGrass = 0;
                
                for k=1:8
                    i2 = i+neigh(k, 1);
                    j2 = j+neigh(k, 2);
                    % Check that the cell is within the grid boundaries
                    if ( i2>=1 && j2>=1 && i2<=X && j2<=Y )
                        neighOrganism = organismMat(i2,j2,:);
                        
                        switch neighOrganism(typeInd)
                            
                            case NOTHING(typeInd)   %Found Mating Loc
                                potentialMatingLocaction = [i2,j2];
                                
                            case currentAnimal(preyTypeInd) %Found Food/Prey
                                if (currentAnimal(stomachInd) < currentAnimal(maxStomachInd))
                                    if (neighOrganism(fatnessInd) > 0)
                                        organismMat(i,j,stomachInd) = currentAnimal(stomachInd) + 1;
                                        currentAnimal(stomachInd) = currentAnimal(stomachInd) + 1;
                                        organismMat(i2,j2,fatnessInd) = neighOrganism(fatnessInd) - 1;
                                        
                                        if (neighOrganism(aliveInd) == 1)   %Alive or already dead?
                                            organismMat(i2,j2,aliveInd) = 0;
                                            
                                            deathlistIndex = deathlistIndex + 1;
                                            deathlist(deathlistIndex,:) = [i2,j2];
                                           % disp('i1')
                                           % i2
                                           % disp('j2')
                                           % j2
                                        end
                                    end
                                end
                                
                            case currentAnimal(typeInd) %Found Mate
                                if (neighOrganism(aliveInd) == 1 &&...
                                    neighOrganism(stomachInd) > neighOrganism(minStomachRepInd) &&...
                                    neighOrganism(isOffspring) == 0)
                                    %Is alive, has enough stomach and is not
                                    %offspring
                                    potentialMate = [i2,j2];
                                end
                                
                            case GRASS(typeInd)  %Found Grass Mating Loc
                                if currentAnimal(typeInd) ~= GRASS(typeInd)
                                    if potentialMatingLocaction(1) == -1    %No Empty Location exists
                                        potentialMatingLocaction = [i2,j2];
                                        matingOnGrass = 1;
                                    end
                                end
                        end
                    end
                end
                
                %Check if we can mate
                if (potentialMate(1) ~= -1) && (potentialMatingLocaction(1) ~= -1)
                    %Check our stomach is enough
                   if currentAnimal(stomachInd) > currentAnimal(minStomachRepInd)
                       if (rand < currentAnimal(repProbInd))
                           %Reproduce
                           currentMate = organismMat(potentialMate(1),potentialMate(2),:);
                           a = potentialMatingLocaction(1);
                           b = potentialMatingLocaction(2);
                           
                           organismMat(i,j,stomachInd) = currentAnimal(stomachInd) - 1;
                           organismMat(potentialMate(1),potentialMate(2),stomachInd) = currentMate(stomachInd) - 1;
                           organismMat(a,b,:) = typeToOrganism(currentAnimal(typeInd),SETUPINDEX);
                           organismMat(a,b,stomachInd) = (currentMate(stomachInd) + currentAnimal(stomachInd))/2;

                           offspringListIndex = offspringListIndex + 1;
                           offspringList (offspringListIndex,:) = [a,b];
                           
                           organismCounter(currentAnimal(typeInd)) = organismCounter(currentAnimal(typeInd)) + 1;
                           if (matingOnGrass == 1)
                               organismCounter(1) = organismCounter(1) - 1;
                           end
                           
                           %{
                           if organismMat(i,j,typeInd) == 3
                               disp(organismMat(potentialMate(1),potentialMate(2),stomachInd));
                               disp(organismMat(i,j,stomachInd));
                                disp(organismMat(potentialMatingLocaction(1),potentialMatingLocaction(2),stomachInd));
                                disp('---------');
                                if organismMat(potentialMatingLocaction(1),potentialMatingLocaction(2),stomachInd) == inf
                                    disp('inf');
                                    disp(organismMat(i,j,typeInd));
                                    disp(organismMat(potentialMate(1),potentialMate(2),typeInd));
                                end
                           end
                           %}
                           
                       end
                   end
                end
                
                
            end
        end
    end
    
    
    if allEmpty == 1
        break;
    end
    
    %remove dead organisms
    %deathlist([1:deathlistIndex],:)
    for i=1:deathlistIndex
        a = deathlist(i,1);
        b = deathlist(i,2);
        organismType = organismMat(a,b,typeInd);
        organismCounter(organismType) = organismCounter(organismType) - 1;
        organismMat(a,b,:) = NOTHING; %becomes nothing after being eaten
        deathCauseMat(organismType,3) = deathCauseMat(organismType,3) + 1;
    end
   
    %Upgrade Offsprings
    for i=1:offspringListIndex
        a = offspringList(i,1);
        b = offspringList(i,2);
        organismMat(a,b,isOffspring) = 0; %becomes adult
    end
    
    
    % Animate
    organismCountMat = [organismCountMat;organismCounter];
    printLand(organismMat(:,:,1),organismCountMat,t+1,deathCauseMat);
    pause(0.00001);
    %pause(0.2)
    
    %writeVideo(vidObj,getframe(fig));
    
end
close(vidObj);
%winopen('sample.avi');

disp('Finished');

%}

