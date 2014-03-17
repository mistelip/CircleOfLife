% Simulate Circle Of life

%------CONSTANTS---------------------------------
TIMESTEPS = 2000;
NUMBER_OF_SPECIES = 3;

% 0 = Nothing
% 1 = Grass
% 2 = Antilope
% 3 = Lion
NUMBER_OF_VARIABLES = 11;
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

NOTHING =   typeToOrganism(0);
GRASS =     typeToOrganism(1);
ANTILOPE =  typeToOrganism(2);
LION =      typeToOrganism(3);
%---------------------------------------------------



% Set parameter values
X=60;              % Grid size (XxY)
Y =60;
beta=0.01;          % Infection rate
gamma=0.01;         % Immunity rate


%create empty land
organismMat = zeros(Y,X);
for i=2:NUMBER_OF_VARIABLES
    organismMat(:,:,i) = zeros(Y,X);
end


for i=1:X
    for j=1:Y
        organismMat(i,j,:) = ANTILOPE;
    end
end

organismMat(30,30,:) = LION;
organismMat(31,30,:) = LION;
organismMat(30,31,:) = LION;
organismMat(31,31,:) = LION;
organismMat(32,32,:) = LION;

%--------populate land

%manual
%{
organismMat(1,1,:) = GRASS;
organismMat(10,10,:) = GRASS;
organismMat(10,9,:) = GRASS;
organismMat(8,8,:) = GRASS;
organismMat(7,8,:) = GRASS;

%%}

organismMat(2,3,:) = ANTILOPE;
organismMat(5,5,:) = ANTILOPE;
organismMat(2,4,:) = ANTILOPE;
organismMat(5,4,:) = ANTILOPE;
organismMat(14,15,:) = ANTILOPE;
organismMat(15,17,:) = ANTILOPE;


organismMat(6,5,:) = LION;
organismMat(15,15,:) = LION;
organismMat(6,6,:) = LION;
organismMat(15,16,:) = LION;

%}

%{
%random Grass
rng('shuffle');
for i=1:400
    x =  randi([1 X]);
    y =  randi([1 Y]);
    disp(x);
    disp(y);
    organismMat(x,y,:) = GRASS;
end


%random Antilope
rng('shuffle');
for i=1:15
    x =  randi([1 X]);
    y =  randi([1 Y]);
    disp(x);
    disp(y);
    organismMat(x,y,:) = ANTILOPE;
end

%random Lion
rng('shuffle');
for i=1:15
    x =  randi([1 X]);
    y =  randi([1 Y]);
    disp(x);
    disp(y);
    organismMat(x,y,:) = LION;
end
%}

%figure;
printLand(organismMat(:,:,1));


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
                organismMat(i,j,:) = typeToOrganism(oldOrganismMat(i,j,becomesInd));
            end
            
            % Iterate over the neighbors
            potentialMatingLocaction = [inf,inf];
            potentialMate = [inf,inf];
            currentAnimal = oldOrganismMat(i,j,:);
            
            
            if (currentAnimal(typeInd) == NOTHING(typeInd))
                %NOTHING
                %count all neighbors to see if they can mate
                typeCount = zeros(1,NUMBER_OF_SPECIES);
                for k=1:8
                    i2 = i+neigh(k, 1);
                    j2 = j+neigh(k, 2);
                    % Check that the cell is within the grid boundaries
                    if ( i2>=1 && j2>=1 && i2<=X && j2<=Y )
                        neighOrganism = oldOrganismMat(i2,j2,:);
                        if (neighOrganism(typeInd) ~= 0)
                            if(neighOrganism(stomachInd) > neighOrganism(minStomachRepInd)...
                                    && neighOrganism(aliveInd) == 1)
                                typeCount(neighOrganism(typeInd)) = typeCount(neighOrganism(typeInd)) + 1;
                            end
                        end
                    end
                end
                [maxAmount,index] = max(typeCount);
                if (maxAmount >= 2)
                    %TODO: store locations and subtract stomachs from
                    %breeding animals

                    temp = typeToOrganism(index);
                    if(rand <= temp(repProbInd))
                        organismMat(i,j,:) = typeToOrganism(index);
                        %disp('birth');
                    else
                        %disp('no birth');
                    end
                    
                    
                end
            else
                %Organism
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
    pause(0.05)
    
    
end
%}

