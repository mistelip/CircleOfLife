function [X,Y,organismMat] = getLand(landNumber,NUM_OF_VARIABLES, setupIndex)

NOTHING =   typeToOrganism(0, setupIndex);
GRASS =     typeToOrganism(1, setupIndex);
ANTILOPE =  typeToOrganism(2, setupIndex);
LION =      typeToOrganism(3, setupIndex);

switch landNumber
    case 1 %All Antilopes with Lions in middle
        X=60;              % Grid size (XxY)
        Y =60;
        organismMat = createEmptyLand(X,Y,NUM_OF_VARIABLES);
        
        for i=1:X
            for j=1:Y
                if i > 27 && i < 30 &&...
                        j > 27 && j < 30
                    organismMat(i,j,:) = LION;
                else
                    organismMat(i,j,:) = ANTILOPE;
                end
            end
        end
    case 2 %Manual Random
        X = 20;
        Y = 20;
        organismMat = createEmptyLand(X,Y,NUM_OF_VARIABLES);
        
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
        organismMat = createEmptyLand(X,Y,NUM_OF_VARIABLES);
        
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
        
end

