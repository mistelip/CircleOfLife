function [organismMat] = createEmptyLand( X,Y,NUMBER_OF_VARIABLES)
%CREATEEMPTYLAND Creates 0,0,0 matrix
%   Detailed explanation goes here
organismMat = zeros(Y,X);
for i=2:NUMBER_OF_VARIABLES
    organismMat(:,:,i) = zeros(Y,X);
end

end

