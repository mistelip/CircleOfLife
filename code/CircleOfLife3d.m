% Simulate Circle Of life

%------CONSTANTS---------------------------------
TIMESTEPS = 10000;
NUMBER_OF_SPECIES = 3;

% 0 = Nothing
% 1 = Grass
% 2 = Antilope
% 3 = Lion
NUMBER_OF_VARIABLES = 11;
SETUPINDEX = 1;

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

NOTHING =   typeToOrganism(0,SETUPINDEX);
GRASS =     typeToOrganism(1,SETUPINDEX);
ANTILOPE =  typeToOrganism(2,SETUPINDEX);
LION =      typeToOrganism(3,SETUPINDEX);
%---------------------------------------------------


[X,Y,organismMat] = getLand(4,NUMBER_OF_VARIABLES,SETUPINDEX);

%Print initial Land
%figure;
printLand(organismMat(:,:,1));
disp('Initial Land Printed, Press 1 sec before start');
pause(1);


% Define the Moore neighborhood, i.e. the 8 nearest neighbors
neigh = [-1 -1; 0 -1; 1 -1; 1 0; 1 1; 0 1; -1 1; -1 0];

% main loop, iterating the time variable, t
for t=1:TIMESTEPS
    deathlist = [];
    oldOrganismMat = organismMat;
    % iterate over all cells in grid x, for index i=1..N and j=1..N
    for i=1:X
        for j=1:Y
            
            %Adjust stomach
            organismMat(i,j,stomachInd) = organismMat(i,j,stomachInd) - 1;
            if (organismMat(i,j,deathProbInd) > rand) || (organismMat(i,j,stomachInd) < 0)
                organismMat(i,j,:) = typeToOrganism(oldOrganismMat(i,j,becomesInd),SETUPINDEX);
            end
            
            % Iterate over the neighbors
            potentialMatingLocaction = [inf,inf];
            potentialMate = [inf,inf];
            currentAnimal = oldOrganismMat(i,j,:);
            
            
            if (currentAnimal(typeInd) == NOTHING(typeInd))
                %NOTHING
                continue;
            else
                %Organism
                potentialMatingLocaction = [-1,-1];
                potentialMate = [-1,-1];
                for k=1:8
                    i2 = i+neigh(k, 1);
                    j2 = j+neigh(k, 2);
                    % Check that the cell is within the grid boundaries
                    if ( i2>=1 && j2>=1 && i2<=X && j2<=Y )
                        neighOrganism = oldOrganismMat(i2,j2,:);
                        
                        switch neighOrganism(typeInd)
                            case NOTHING(typeInd)   %Found Mating Loc
                                potentialMatingLocaction = [i2,j2];
                            case currentAnimal(preyTypeInd) %Found Food
                                if (currentAnimal(stomachInd) < currentAnimal(maxStomachInd))
                                    if (oldOrganismMat(i2,j2,fatnessInd) > 0)
                                        organismMat(i,j,stomachInd) = oldOrganismMat(i,j,stomachInd) + 1;
                                        organismMat(i2,j2,aliveInd) = 0;
                                        organismMat(i2,j2,fatnessInd) = oldOrganismMat(i2,j2,fatnessInd) - 1;
                                        deathlist = [deathlist; [i2,j2]];
                                    end
                                end
                            case currentAnimal(typeInd) %Found Mate
                                if neighOrganism(stomachInd) > neighOrganism(minStomachRepInd)
                                    %Has enough stomach,Is enough fed
                                    potentialMate = [i2,j2];
                                end
                            case GRASS(typeInd)
                                if potentialMatingLocaction(1) == -1 %Found Mating Loc
                                    potentialMatingLocaction = [i2,j2];
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
                           organismMat(i,j,stomachInd) = organismMat(i,j,stomachInd) - 1;
                           organismMat(potentialMate(1),potentialMate(2),stomachInd) = organismMat(potentialMate(1),potentialMate(2),stomachInd) - 1;
                           organismMat(potentialMatingLocaction(1),potentialMatingLocaction(2),:) = typeToOrganism(currentAnimal(typeInd),SETUPINDEX);
                       end
                   end
                end
                    
            end
            
        end
        
    end
    
    %remove dead organisms
    [nDeaths,temp] = size(deathlist);
    for i=1:nDeaths
        organismMat(deathlist(i,1),deathlist(i,2),:) = NOTHING;
    end
    
    % Animate
    printLand(oldOrganismMat(:,:,1));
    %pause(0.00001);
    pause(0.3)
    
    
end

disp('Finished');

%}

