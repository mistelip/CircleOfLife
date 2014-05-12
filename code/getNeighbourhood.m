function [ neigh] = getNeighbourhood(s)
%GETNEIGHBOURHOOD Generates a von Neumann neighborhood with manhattan disctance s
xDir = -s:s;
yDir = ones(1,(s*2)+1);
yDir(1) = 1;
neigh = [];
for neighIt = -s:s
    if (neighIt ~= 0)
        addNeigh = [xDir', ones((s*2)+1,1)*neighIt];
    else
        addNeigh = [[-s:-1,1:s]', ones((s*2),1)*neighIt];
    end
    neigh = [neigh; addNeigh];
end
end

