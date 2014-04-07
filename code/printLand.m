function [] = printLand( mat, organismCounter )
%PRINTLAND Summary of this function goes here
%   Detailed explanation goes here

    color_Lion = [1 0 0];
    color_Antilope = [244/255, 164/255, 96/255];
    color_Grass = [0 1 0];
    color_Nothing = [0 0 0];
    clf                                 % Clear figure
    
    subplot(1, 2, 1);
    imagesc(mat, [0 3]);                   % Display grid                
    colormap([color_Nothing; color_Grass; color_Antilope; color_Lion]);    
   
    subplot(1, 2, 2);
    XLABELS = {'Grass','Antilope','Lion'};
    bar(organismCounter);
    set(gca,'xticklabel',XLABELS);
end

