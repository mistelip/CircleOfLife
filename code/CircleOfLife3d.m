% Simulate Circle Of life

%------CONSTANTS---------------------------------
SETUPINDEX = 1;
LAND_NUMBER = 3;

neigh_8 = getNeighbourhood(1); % Define the Moore neighborhood
neigh_8ext = [-1 -1; 0 -1; 1 -1; 1 0; 1 1; 0 1; -1 1; -1 0; 0 -2; 0 2; -2 0; 2 0];
neigh_2 = getNeighbourhood(2);
neigh_3 = getNeighbourhood(3);
neigh = neigh_8ext;


% 0 = Nothing
% 1 = Grass
% 2 = Antelope
% 3 = Lion
NUMBER_OF_SPECIES = 3;
TIMESTEPS = 281474976710650; %Large number for nearly unlimited timesteps. Change window size to break timestep loop
NUMBER_OF_VARIABLES = 12;

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
ANTELOPE =  typeToOrganism(2,SETUPINDEX);
LION =      typeToOrganism(3,SETUPINDEX);

%---------------------------------------------------
[X,Y,organismMat,organismCountMat] = getLand(LAND_NUMBER,NUMBER_OF_VARIABLES,SETUPINDEX);
deathCauseMat = zeros(3,3);

%Initialize Video Writer
fig = figure;
set(fig,'Color',[0 0 0])
set(fig, 'Position', [10 10 1300 800])
FILENAME = [datestr(clock, 30),'.avi'];
vidObj = VideoWriter(FILENAME);
vidObj.Quality= 100;
open(vidObj);

%Print initial Land
printLand(organismMat(:,:,1),organismCountMat(1,:),1,deathCauseMat);

disp('Initial Land Printed, 1 sec before start');
pause(1);

% generate random order for updates
xlocs = 1:X;
ylocs = zeros(1,X);
ylocs(1) = 1;
locations = [repmat(xlocs,[1,Y]) ; cumsum(repmat(ylocs,[1,Y]))];

% main loop, iterating the time variable, t
for t=1:TIMESTEPS
    allEmpty = 1; %If the land is empty we escape the loop
    deathlist = ones(X*Y,2);
    deathlistIndex = 0; 
    
    %Adjust stomach -> vectorized for performance
    organismMat(:,:,stomachInd) = organismMat(:,:,stomachInd) - organismMat(:,:,foodDigestInd);
    randIndexes = randperm(X*Y);
    
    for iter=1:X*Y
        %Take a random location
        i = locations(1,randIndexes(iter));
        j = locations(2,randIndexes(iter));
        currentAnimal = organismMat(i,j,:);
        
        if (currentAnimal(aliveInd) == 0 || (currentAnimal(isOffspring) == 1))
            continue; %Animal is dead and is on deathlist or is born in this turn
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
            if (iDie == 1) %Kill organism
                newType = currentAnimal(becomesInd);
                newOrganism = typeToOrganism(newType,SETUPINDEX);
                organismMat(i,j,:) = newOrganism;
                continue;
            end
            
            %Check Neighborhood
            %Organism
            potentialMatingLocaction = [-1,-1];
            potentialMate = [-1,-1];
            randIndexes2 = randperm(size(neigh,1));
            
            for k=1:size(neigh,1)
                i2 = mod((i+neigh(randIndexes2(k), 1))-1,X) + 1;
                j2 = mod((j+neigh(randIndexes2(k), 2))-1,Y) + 1;
                neighOrganism = organismMat(i2,j2,:);
                
                if (currentAnimal(typeInd) == 2)
                    % disp('');
                end;
                
                switch neighOrganism(typeInd)
                    
                    case NOTHING(typeInd)   %Found Mating Loc
                        potentialMatingLocaction = [i2,j2];
                        
                    case currentAnimal(preyTypeInd) %Found Food/Prey
                        if (currentAnimal(stomachInd) < currentAnimal(maxStomachInd))
                            if (neighOrganism(fatnessInd) > 0 && neighOrganism(isOffspring) == 0)
                                organismMat(i,j,stomachInd) = currentAnimal(stomachInd) + 1;
                                currentAnimal(stomachInd) = currentAnimal(stomachInd) + 1;
                                organismMat(i2,j2,fatnessInd) = neighOrganism(fatnessInd) - 1;
                                
                                if (neighOrganism(aliveInd) == 1)   %Alive or already dead?
                                    organismMat(i2,j2,aliveInd) = 0;
                                    deathlistIndex = deathlistIndex + 1;
                                    deathlist(deathlistIndex,:) = [i2,j2];
                                    deathCauseMat(neighOrganism(typeInd),3) = deathCauseMat(neighOrganism(typeInd),3) + 1;
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
                end
                
                %Check for mating location
                if neighOrganism(typeInd) == GRASS(typeInd)  %Found Grass Mating Loc
                    if currentAnimal(typeInd) ~= GRASS(typeInd)
                        if potentialMatingLocaction(1) == -1    %No Empty Location exists
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
                        currentMate = organismMat(potentialMate(1),potentialMate(2),:);
                        a = potentialMatingLocaction(1);
                        b = potentialMatingLocaction(2);
                        
                        newCurrentStomach = currentAnimal(stomachInd) - 1;
                        newMateStomach = currentMate(stomachInd) - 1;
                        
                        organismMat(i,j,stomachInd) = newCurrentStomach;
                        organismMat(potentialMate(1),potentialMate(2),stomachInd) = newMateStomach;
                        
                        organismMat(a,b,:) = typeToOrganism(currentAnimal(typeInd),SETUPINDEX);
                        organismMat(a,b,stomachInd) = ((newCurrentStomach + newMateStomach)/2)+1;
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
        newOffspring = (organismMat(a,b,isOffspring) == 1);
        if (newOffspring)
            %Antelope eats Grass and 2 Lions/Antelopes put offspring on it.
            %We want to keep it this way
        else
            organismMat(a,b,:) = NOTHING; %becomes nothing after being eaten
        end
    end
    
    %Upgrade Offsprings
    organismMat(:,:,isOffspring) =  zeros(X,Y);
    
    %Set Counters
    organismCounter(1) = sum(sum(organismMat(:,:,typeInd) == 1));
    organismCounter(2) = sum(sum(organismMat(:,:,typeInd) == 2));
    organismCounter(3) = sum(sum(organismMat(:,:,typeInd) == 3));
    organismCountMat = [organismCountMat;organismCounter];
    
    %{
    %Log average stomachs:
    stomachs = (organismMat(:,:,stomachInd));
    logg('Stomach Annte: ', mean(stomachs((logical(organismMat(:,:,typeInd) == 2)))));
    logg('Stomach Lion: ', mean(stomachs((logical(organismMat(:,:,typeInd) == 3)))));
    %}
    
    % Animate
    printLand(organismMat(:,:,1),organismCountMat,t+1,deathCauseMat);
    pause(0.00001);
    %pause(0.2)
    
    try
        writeVideo(vidObj,getframe(fig));
    catch
        %Breaks if plot was resized
        break;
    end
    
end
close(vidObj);
winopen(FILENAME);
disp(['Finished: ',FILENAME]);

