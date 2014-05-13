function [ret] = typeToOrganism( type, setupIndex )

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

switch setupIndex %land 3 & neigh_8ext
    case 1  
        switch type
            case 0      %1    2       3       4dige   5          6       7death                        8       9   10      11rep    12
                ret =   [0,   -1,     0,      0,      inf,      0,      Inf,                           0,      0,  inf,    0,       1];
            case 1
                ret =   [1,   -1,     0,      0,      inf,      0,      expectedAgeToDeathProb(5),     8,      1,  0,      0.7,      1];
            case 2
                ret =   [2,   1,      0,      1/2,    10,      10,       expectedAgeToDeathProb(10),     8,      1,  0,      1,      1];
            case 3
                ret =   [3,   2,      1,      1,    10,       10,      expectedAgeToDeathProb(10),     0,      1,  0,      1,     1];
        end
    case 2 %Land 16 & neigh_8ext
        
        switch type
            case 0      %1    2       3       4dige   5          6       7death                        8       9   10      11rep    12
                ret =   [0,   -1,     0,      0,      inf,      0,      Inf,                           0,      0,  inf,    0,       1];
            case 1
                ret =   [1,   -1,     0,      0,      inf,      0,      expectedAgeToDeathProb(5),     8,      1,  0,      0.7,      1];
            case 2
                ret =   [2,   1,      0,      1/2,    10,      10,       expectedAgeToDeathProb(9),     8,      1,  0,      1,      1];
            case 3
                ret =   [3,   2,      1,      1/1,    10,       10,      expectedAgeToDeathProb(5),     0,      1,  0,      1,     1];
        end
    case 3 %Land 18 & neigh_3
        
        switch type
            case 0      %1    2       3       4dige   5          6       7death                        8       9   10      11rep    12
                ret =   [0,   -1,     0,      0,      inf,      0,      Inf,                           0,      0,  inf,    0,       1];
            case 1
                ret =   [1,   -1,     0,      0,      inf,      0,      expectedAgeToDeathProb(5),     2,      1,  0,      0.7,      1];
            case 2
                ret =   [2,   1,      0,      1/5,    2,      2,       expectedAgeToDeathProb(9),     8,      1,  1,      1,      1];
            case 3
                ret =   [3,   2,      1,      1/3,    2,       2,      expectedAgeToDeathProb(10),     0,      1,  1,      0.6,     1];
        end
        
        
    case 4 % Only antelopes and Grass Land 19
        
        switch type
            case 0      %1    2       3       4dige   5          6       7death                        8       9   10      11rep    12
                ret =   [0,   -1,     0,      0,      inf,      0,      Inf,                           0,      0,  inf,    0,       1];
            case 1
                ret =   [1,   -1,     0,      0,      inf,      0,      expectedAgeToDeathProb(5),     2,      1,  0,      0.7,      1];
            case 2
                ret =   [2,   1,      0,      1,    2,      2,       expectedAgeToDeathProb(9),     8,      1,  1,      1,      1];
            case 3
                ret =   [3,   2,      1,      1/3,    2,       2,      expectedAgeToDeathProb(10),     0,      1,  1,      0.6,     1];
        end
        
    case 5 %Lions overfeeding Land 16 & neigh_8ext
        
       switch type
            case 0      %1    2       3       4dige   5          6       7death                        8       9   10      11rep    12
                ret =   [0,   -1,     0,      0,      inf,      0,      Inf,                           0,      0,  inf,    0,       1];
            case 1
                ret =   [1,   -1,     0,      0,      inf,      0,      expectedAgeToDeathProb(5),     8,      1,  0,      0.7,      1];
            case 2
                ret =   [2,   1,      0,      1/2,    10,      10,       expectedAgeToDeathProb(9),     12,      1,  0,      1,      1];
            case 3
                ret =   [3,   2,      1,      1/1,    10,       inf,      expectedAgeToDeathProb(10),     0,      1,  0,      1,     1];
        end
    case 6 %Antilope overfeeding
        
        switch type
            case 0      %1    2       3       4dige   5          6       7death                        8       9   10      11rep    12
                ret =   [0,   -1,     0,      0,      inf,      0,      Inf,                           0,      0,  inf,    0,       1];
            case 1
                ret =   [1,   -1,     0,      0,      inf,      0,      expectedAgeToDeathProb(5),     8,      1,  0,      0.7,      1];
            case 2
                ret =   [2,   1,      0,      1/2,    10,      inf,       expectedAgeToDeathProb(9),     12,      1,  0,      1,      1];
            case 3
                ret =   [3,   2,      1,      1/1,    10,       13,      expectedAgeToDeathProb(10),     0,      1,  0,      1,     1];
        end
    case 7 %Lions and Antilope overfeeding
        
        switch type
            case 0      %1    2       3       4dige   5          6       7death                        8       9   10      11rep    12
                ret =   [0,   -1,     0,      0,      inf,      0,      Inf,                           0,      0,  inf,    0,       1];
            case 1
                ret =   [1,   -1,     0,      0,      inf,      0,      expectedAgeToDeathProb(5),     8,      1,  0,      0.7,      1];
            case 2
                ret =   [2,   1,      0,      1/2,    10,      inf,       expectedAgeToDeathProb(9),     12,      1,  0,      1,      1];
            case 3
                ret =   [3,   2,      1,      1/1,    10,       inf,      expectedAgeToDeathProb(10),     0,      1,  0,      1,     1];
        end
        
    case 8 %Map 18, neighbourhood 2
        
        switch type
            case 0      %1    2       3       4dige   5          6       7death                        8       9   10      11rep    12
                ret =   [0,   -1,     0,      0,      inf,      0,      Inf,                           0,      0,  inf,    0,       1];
            case 1
                ret =   [1,   -1,     0,      0,      inf,      0,      expectedAgeToDeathProb(5),     8,      1,  0,      0.7,      1];
            case 2
                ret =   [2,   1,      0,      1/2,    10,      10,       expectedAgeToDeathProb(9),     8,      1,  0,      1,      1];
            case 3
                ret =   [3,   2,      1,      1/1,    10,       11,      expectedAgeToDeathProb(10),     0,      1,  0,      1,     1];
        end
        
end
end