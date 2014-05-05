function [X,Y,organismMat, organismCounter] = getLand(landNumber,NUM_OF_VARIABLES, setupIndex)

NOTHING =   typeToOrganism(0, setupIndex);
GRASS =     typeToOrganism(1, setupIndex);
ANTILOPE =  typeToOrganism(2, setupIndex);
LION =      typeToOrganism(3, setupIndex);
organismCounter = zeros(1,3);

switch landNumber
    case 0 %Simple 3x3 Grass with 1 Antilope
        X=3;              % Grid size (XxY)
        Y =3;
        
        organismMat = createFlatLand(X,Y,NUM_OF_VARIABLES, setupIndex,0);
        organismMat(2,2,:) = ANTILOPE;
        organismMat(2,3,:) = ANTILOPE;
        organismCounter(2) = 2;
    case 1 %All Antilopes with Lions in middle
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
                    organismMat(i,j,:) = ANTILOPE;
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
    case 3 %Randomized
        X = 30;
        Y = 30;
        organismMat = createFlatLand(X,Y,NUM_OF_VARIABLES,setupIndex,0);
        
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
    case 4  %Small Antilope Herd in Middle
        X=20;              % Grid size (XxY)
        Y =20;
        organismMat = createFlatLand(X,Y,NUM_OF_VARIABLES,setupIndex,0);
        
        for i=1:X
            for j=1:Y
                if i >= 8 && i <= 12 &&...
                        j >= 8 && j <= 12
                    organismMat(i,j,:) = ANTILOPE;
                end
            end
        end
    case 5 %Grass Land with herd of antilope in the middle
        X=20;              % Grid size (XxY)
        Y =20;
        organismMat = createFlatLand(X,Y,NUM_OF_VARIABLES,setupIndex,1);
        
        %{
        for i=1:X
            for j=1:Y
                if i > 8 && i < 12 &&...
                        j >= 8 && j <= 12
                    organismMat(i,j,:) = ANTILOPE;
                end
            end
        end
        %}
    case 6 %Only Antilipes
        X = 40;
        Y = 40;
        organismMat = createFlatLand(X,Y,NUM_OF_VARIABLES,setupIndex,2);
        
   case 7 %Only Lions
        X = 10;
        Y = 10;
        organismMat = createFlatLand(X,Y,NUM_OF_VARIABLES,setupIndex,3);
    case 8 %Only Grass + antilopes herd
        X = 50;
        Y = 50;
        organismMat = createFlatLand(X,Y,NUM_OF_VARIABLES,setupIndex,1);
        for i=1:X
            for j=1:Y
                if i >= 20 && i <= 30 &&...
                        j >= 20 && j <= 30
                    organismMat(i,j,:) = ANTILOPE;
                end
            end
        end
    case 9 %Half Antilope, Half Grass
        X = 50;
        Y = 50;
        organismMat = createFlatLand(X,Y,NUM_OF_VARIABLES,setupIndex,1);
        for i=X/2:X
            for j=1:Y
                organismMat(i,j,:) = ANTILOPE;
            end
        end
    case 10 %All Antilopes  + stripe of grass
        X = 50;
        Y = 50;
        numStripes = 1;
        
        organismMat = createFlatLand(X,Y,NUM_OF_VARIABLES,setupIndex,2);
        for i=X/2:(X/2 + numStripes)
            for j=1:Y
                organismMat(i,j,:) = GRASS;
            end
        end
        
    case 11 %All Grass + stripe of antilope
        X = 50;
        Y = 50;
        numStripes = 1;
        
        organismMat = createFlatLand(X,Y,NUM_OF_VARIABLES,setupIndex,1);
        for i=X/2:(X/2 + numStripes)
            for j=1:Y
                organismMat(i,j,:) = ANTILOPE;
            end
        end
        
case 12 %All Grass + stripe of antilope + stripe of lion
        X = 50;
        Y = 50;
        numAntilopStripes = 12;
        numLionStripes = 2;
        
        organismMat = createFlatLand(X,Y,NUM_OF_VARIABLES,setupIndex,1);
        for i=X/2:(X/2 + numAntilopStripes)
            for j=1:Y
                organismMat(i,j,:) = ANTILOPE;
            end
        end
        
        for i=(X/2+(numAntilopStripes/2)-(numLionStripes/2)):(X/2+(numAntilopStripes/2)+(numLionStripes/2))
            for j=Y/2:Y
                organismMat(i,j,:) = LION;
            end
        end
end

for i=1:X
    for j=1:Y                
        organismMat(i,j,12) = 0; %No one isOffpsring    
    end
end



