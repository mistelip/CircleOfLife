function [ret] = typeToOrganism( type, setupIndex )
%TYPETOORGANISM Summary of this function goes here
%   Detailed explanation goes here

switch setupIndex
    case 1
        switch type
            case 0      %1     2       3       4       5       6       7       8       9   10      11
                ret =   [0,   -1,     0,      0,      inf,    0,      inf,    0,      0,  inf,    0];
            case 1
                ret =   [1,   -1,     0,      0,      inf,    0,      0.3,    2,      1,  0,      0.5];
            case 2
                ret =   [2,   1,      1,      0.5,      10,     30,     0.1,    2,      1,  10,      0.3];
            case 3
                ret =   [3,   2,      1,      0.5,      10,     inf,    0.02,   0,      1,  5,      0.2];
        end
    case 2 %Super Reproduction
        
        switch type
            case 0      %1     2       3       4       5       6       7       8       9   10      11
                ret =   [0,   -1,     0,      0,      inf,    0,      inf,    0,      0,  inf,    0];
            case 1
                ret =   [1,   -1,     0,      0,      inf,    0,      0.3,    8,      1,  0,      0.9];
            case 2
                ret =   [2,   1,      1,      0.2,      10,     30,     0.1,    2,      1,  10,      0.9];
            case 3
                ret =   [3,   2,      1,      0.2,      10,     inf,    0.02,   0,      1,  5,      0.9];
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
%}