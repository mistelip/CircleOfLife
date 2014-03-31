function [organismMat] = createFlatLand(X,Y,NUMBER_OF_VARIABLES,setupIndex,LandType)
%   CREATEFLATLAND Creates (X,Y,NUMBER_OF_VARIABLES)-matrix populated with
%   LandType-organism
% 1. get Organism type
% 2. transpose in 3D to get a (1,1,NUMBER_OF_VARIABLES)-vector
% 3. replicate this vector X*Y times to fill the entire land with this
%    organism
organismMat = repmat(permute(typeToOrganism(LandType,setupIndex),[1,3,2]),[X,Y,1]);
end

