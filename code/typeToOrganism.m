function [ret] = typeToOrganism( type )
%TYPETOORGANISM Summary of this function goes here
%   Detailed explanation goes here
switch type
    case 0
        ret =   [0, -1, 0, 0, inf, 0, inf, 0, 0, inf];
    case 1
        ret =     [1, -1, 0, 0, inf, 0, 100, 5, 1, 0];
    case 2
        ret =  [2, 1, 1, 1, 10, 30, 50, 2, 1, 2];
    case 3
        ret =      [3, 2, 1, 1, 10, 15, 50, 0, 1, 5];
end
end

