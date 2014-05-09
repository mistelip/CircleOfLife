function [X,Y,organismMat, organismCounter] = getLand(landNumber,NUM_OF_VARIABLES, setupIndex)

NOTHING =   typeToOrganism(0, setupIndex);
GRASS =     typeToOrganism(1, setupIndex);
ANTELOPE =  typeToOrganism(2, setupIndex);
LION =      typeToOrganism(3, setupIndex);
organismCounter = zeros(1,3);
typeInd = 1;

switch landNumber
    case 0 %20x20 Grass with 1 Antelope
        X=10;              % Grid size (XxY)
        Y =10;
        organismMat = createFlatLand(X,Y,NUM_OF_VARIABLES, setupIndex,2);
        organismMat(2,2,:) = ANTELOPE;
        organismMat(2,3,:) = ANTELOPE;
    case 1 %All Antelopes with Lions in middle
        X=50;              % Grid size (XxY)
        Y =50;
        
        organismMat = createFlatLand(X,Y,NUM_OF_VARIABLES, setupIndex,0);
        organismCounter(1) = 50*50;
        
        for i=1:X
            for j=1:Y
                if i >= 25 && i <= 30 &&...
                        j >= 25 && j <= 30
                    organismMat(i,j,:) = LION;
                    organismCounter(3) = organismCounter(3) + 1;
                    organismCounter(1) = organismCounter(1) - 1;
                    
                else
                    organismCounter(2) = organismCounter(2) + 1;
                    organismCounter(1) = organismCounter(1) - 1;
                    organismMat(i,j,:) = ANTELOPE;
                end
            end
        end
    case 2 %Manual Random
        X = 20;
        Y = 20;
        organismMat = createFlatLand(X,Y,NUM_OF_VARIABLES,setupIndex,0);
        
        organismMat(1,1,:) = GRASS;
        organismMat(10,10,:) = GRASS;
        organismMat(10,9,:) = GRASS;
        organismMat(8,8,:) = GRASS;
        organismMat(7,8,:) = GRASS;
        
        organismMat(2,3,:) = ANTELOPE;
        organismMat(5,5,:) = ANTELOPE;
        organismMat(2,4,:) = ANTELOPE;
        organismMat(5,4,:) = ANTELOPE;
        organismMat(14,15,:) = ANTELOPE;
        organismMat(15,17,:) = ANTELOPE;
        
        
        organismMat(6,5,:) = LION;
        organismMat(15,15,:) = LION;
        organismMat(6,6,:) = LION;
        organismMat(15,16,:) = LION;
    case 3 %Randomized
        X = 30;
        Y = 30;
        organismMat = createFlatLand(X,Y,NUM_OF_VARIABLES,setupIndex,0);
        
        %random Grass
        rng('shuffle');
        for i=1:((X*Y)*(400/900))
            x =  randi([1 X]);
            y =  randi([1 Y]);
            disp(x);
            disp(y);
            organismMat(x,y,:) = GRASS;
        end
        %random Antelope
        rng('shuffle');
        for i=1:((X*Y)*(40/900))
            x =  randi([1 X]);
            y =  randi([1 Y]);
            disp(x);
            disp(y);
            organismMat(x,y,:) = ANTELOPE;
        end
        %random Lion
        rng('shuffle');
        for i=1:((X*Y)*(40/900))
            x =  randi([1 X]);
            y =  randi([1 Y]);
            disp(x);
            disp(y);
            organismMat(x,y,:) = LION;
        end
    case 4  %Small Antelope Herd in Middle
        X=20;              % Grid size (XxY)
        Y =20;
        organismMat = createFlatLand(X,Y,NUM_OF_VARIABLES,setupIndex,0);
        
        for i=1:X
            for j=1:Y
                if i >= 8 && i <= 12 &&...
                        j >= 8 && j <= 12
                    organismMat(i,j,:) = ANTELOPE;
                end
            end
        end
    case 5 %Grass Land with herd of antelope in the middle
        X=20;              % Grid size (XxY)
        Y =20;
        organismMat = createFlatLand(X,Y,NUM_OF_VARIABLES,setupIndex,1);
        
        %{
        for i=1:X
            for j=1:Y
                if i > 8 && i < 12 &&...
                        j >= 8 && j <= 12
                    organismMat(i,j,:) = ANTELOPE;
                end
            end
        end
        %}
    case 6 %Only Antilipes
        X = 30;
        Y = 30;
        organismMat = createFlatLand(X,Y,NUM_OF_VARIABLES,setupIndex,2);
    case 7 %Only Lions
        X = 10;
        Y = 10;
        organismMat = createFlatLand(X,Y,NUM_OF_VARIABLES,setupIndex,3);
    case 8 %Only Grass + antelopes herd
        X = 50;
        Y = 50;
        organismMat = createFlatLand(X,Y,NUM_OF_VARIABLES,setupIndex,1);
        for i=1:X
            for j=1:Y
                if i >= 20 && i <= 30 &&...
                        j >= 20 && j <= 30
                    organismMat(i,j,:) = ANTELOPE;
                end
            end
        end
    case 9 %Half Antelope, Half Grass
        X = 50;
        Y = 50;
        organismMat = createFlatLand(X,Y,NUM_OF_VARIABLES,setupIndex,1);
        for i=X/2:X
            for j=1:Y
                
                organismMat(i,j,:) = ANTELOPE;
            end
        end
    case 10 %All Antelopes  + stripe of grass
        X = 50;
        Y = 50;
        numStripes = 1;
        
        organismMat = createFlatLand(X,Y,NUM_OF_VARIABLES,setupIndex,2);
        for i=X/2:(X/2 + numStripes)
            for j=1:Y
                organismMat(i,j,:) = GRASS;
            end
        end
        
    case 11 %All Grass + stripe of antelope
        X = 20;
        Y = 20;
        numStripes = 1;
        
        organismMat = createFlatLand(X,Y,NUM_OF_VARIABLES,setupIndex,1);
        organismCounter(1) = X*Y;
        for i=X/2:(X/2 + numStripes)
            for j=1:Y
                organismCounter(2) = organismCounter(2) +1;
                organismCounter(1) = organismCounter(1) -1;
                organismMat(i,j,:) = ANTELOPE;
            end
        end
    case 12 %All Grass + stripe of antelope + stripe of lion
        X = 50;
        Y = 50;
        numAntilopStripes = 12;
        numLionStripes = 2;
        
        organismMat = createFlatLand(X,Y,NUM_OF_VARIABLES,setupIndex,1);
        organismCounter(1) = X*Y;
        for i=X/2:(X/2 + numAntilopStripes)
            for j=1:Y
                organismMat(i,j,:) = ANTELOPE;
                organismCounter(1) = organismCounter(1) -1;
                organismCounter(2) = organismCounter(2)+1;
            end
        end
        
        for i=(X/2+(numAntilopStripes/2)-(numLionStripes/2)):(X/2+(numAntilopStripes/2)+(numLionStripes/2))
            for j=Y/2:Y
                organismMat(i,j,:) = LION;
                organismCounter(1) = organismCounter(1) -1;
                organismCounter(3) = organismCounter(3)+1;
            end
        end
        
    case 13 %All Grass + stripe of antelope + stripe of lion
        
        
        X = 10;
        Y = 10;
        organismMat = createFlatLand(X,Y,NUM_OF_VARIABLES,setupIndex,0);
        
        %fill half with random Grass
        rng('shuffle');
        for i=1:(X*Y)/2
            x =  randi([1 X]);
            y =  randi([1 Y]);
            while (organismMat(x,y,typeInd) == GRASS(typeInd))
                x =  randi([1 X]);
                y =  randi([1 Y]);
            end
            organismMat(x,y,:) = GRASS;
        end
        organismCounter(1) = X*Y/2;
        
    case 14 %All Grass + stripe of antelope + stripe of lion
        
        
        X = 6;
        Y = 6;
        organismMat = createFlatLand(X,Y,NUM_OF_VARIABLES,setupIndex,2);
        
        for i=1:X
            for j=1:Y
                if (i >= 2 && i <= 5) && (j >= 2 && j <= 5)
                    organismMat(i,j,:) = GRASS;
                end
                
                
                if (i == 3 || i == 4) && (j == 3 || j == 4)
                    organismMat(i,j,:) = LION;
                end
            end
        end
    case 15 %All rANDOM
        
        
        X = 30;
        Y = 30;
        organismMat = createFlatLand(X,Y,NUM_OF_VARIABLES,setupIndex,0);
        
        %fill half with random Grass
        rng('default');
        
        for i=1:(X*Y)/4
            x =  randi([1 X]);
            y =  randi([1 Y]);
            while (organismMat(x,y,typeInd) == LION(typeInd))
                x =  randi([1 X]);
                y =  randi([1 Y]);
            end
            organismMat(x,y,:) = LION;
        end
        for i=1:(X*Y)/2
            x =  randi([1 X]);
            y =  randi([1 Y]);
            while (organismMat(x,y,typeInd) == GRASS(typeInd))
                x =  randi([1 X]);
                y =  randi([1 Y]);
            end
            organismMat(x,y,:) = GRASS;
        end
        for i=1:(X*Y)/2
            x =  randi([1 X]);
            y =  randi([1 Y]);
            while (organismMat(x,y,typeInd) == ANTELOPE(typeInd))
                x =  randi([1 X]);
                y =  randi([1 Y]);
            end
            organismMat(x,y,:) = ANTELOPE;
        end
    case 16 %Randomized
        X = 100;
        Y = 100;
        organismMat = createFlatLand(X,Y,NUM_OF_VARIABLES,setupIndex,0);
        
        %random Grass
        rng('shuffle');
        for i=1:((X*Y)*(400/900))
            x =  randi([1 X]);
            y =  randi([1 Y]);
            disp(x);
            disp(y);
            organismMat(x,y,:) = GRASS;
        end
        %random Antelope
        rng('shuffle');
        for i=1:((X*Y)*(40/900))
            x =  randi([1 X]);
            y =  randi([1 Y]);
            disp(x);
            disp(y);
            organismMat(x,y,:) = ANTELOPE;
        end
        %random Lion
        rng('shuffle');
        for i=1:((X*Y)*(40/900))
            x =  randi([1 X]);
            y =  randi([1 Y]);
            disp(x);
            disp(y);
            organismMat(x,y,:) = LION;
        end
        
end

for i=1:X
    for j=1:Y
        organismMat(i,j,12) = 0; %No one isOffpsring
    end
end



