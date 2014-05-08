function [ret] = typeToOrganism( type, setupIndex )

switch setupIndex
    case 1
        switch type
            case 0      %1     2       3       4       5       6       7       8       9   10      11       12
                ret =   [0,   -1,     0,      0,      inf,    0,      inf,    0,      0,  inf,    0,         1];
            case 1
                ret =   [1,   -1,     0,      0,      inf,    0,      0.3,    2,      1,  0,      0.5,       1];
            case 2
                ret =   [2,   1,      1,      0.5,      10,     30,     0.1,    2,      1,  10,      0.3,    1];
            case 3
                ret =   [3,   2,      1,      0.5,      10,     inf,    0.02,   0,      1,  5,      0.2,     1];
        end
    case 2 %Land 0
        
        switch type
            case 0      %1     2       3       4       5       6       7       8       9   10      11       12
                ret =   [0,   -1,     0,      0,      inf,    0,      inf,    0,      0,  inf,    0,         1];
            case 1
                ret =   [1,   -1,     0,      0,      inf,    0,      0.2,    8,      1,  0,      0.5,       1];
            case 2
                ret =   [2,   1,      1,      0.5,      10,     9,     0.3,    2,      1,  2,      1,    1];
            case 3
                ret =   [3,   2,      1,      1/3,      10,     9,    0.02,   0,      1,  1,      0.5 ,          1];
        end
    case 3 
        
        switch type
            case 0      %1     2       3       4       5       6       7       8       9   10      11       12
                ret =   [0,   -1,     0,      0,      inf,    0,      inf,    0,      0,  inf,    0,         1];
            case 1
                ret =   [1,   -1,     0,      0,      inf,    0,      0.2,    8,      1,  0,      0.3,       1];
            case 2
                ret =   [2,   1,      1,      0.1,      10,     9,     0.3,    2,      1,  2,      0.5,    1];
            case 3
                ret =   [3,   2,      1,      1/3,      10,     9,    0.02,   0,      1,  1,      0.5 ,          1];
        end
        
    case 4
        
        switch type
            case 0      %1    2       3       4       5       6       7       8       9   10      11       12
                ret =   [0,   -1,     0,      0,      inf,    0,      inf,    0,      0,  inf,    0,       1];
            case 1
                ret =   [1,   -1,     0,      0,      inf,    0,      0.15,    8,      1,  0,      0.3,     1];
            case 2
                ret =   [2,   1,      1,      0.1,    10,     9,      0.1,    8,      1,  2,      0.7,     1];
            case 3
                ret =   [3,   2,      1,      0.15,    10,     9,      0.2,   0,      1,  1,      0.5 ,    1];
        end
        
    case 5
        
        switch type
            case 0      %1    2       3       4dige   5       6       7death  8       9   10      11rep    12
                ret =   [0,   -1,     0,      0,      inf,    0,      inf,    0,      0,  inf,    0,       1];
            case 1
                ret =   [1,   -1,     0,      0,      inf,    0,      0,    8,      1,  0,      1,     1];
            case 2
                 ret =   [2,   1,      1,      1/7,    2,     1,      0,    8,      1,  0,      1,     1];
            case 3
                ret =   [3,   2,      1,      0.05,    30,     5,      0.25,   0,      1,  1,      0.7 ,    1];
        end
end
end

%{
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

isOffspring = 12    %Can we reproduce?
%}