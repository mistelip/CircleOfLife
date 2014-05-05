function [] = printLand( mat, organismCountMat, t)
%PRINTLAND Summary of this function goes here
%   Detailed explanation goes here

    color_Lion = [1 0 0];
    color_Antilope = [244/255, 164/255, 96/255];
    color_Grass = [0 1 0];
    color_Nothing = [0 0 0];
    clf                                 % Clear figure
    

    %Land
    subplot(2, 2, 1);
    imagesc(mat, [0 3]);                   % Display grid                
    colormap([color_Nothing; color_Grass; color_Antilope; color_Lion]); 
    axis off;
   
    
    %Age/Hunger Death
    %subplot(2, 2, 2);
  %  XLABELS = {'Grass','Antilope','Lion'};
  %  bar(organismCounter);
  %  set(gca,'xticklabel',XLABELS);
    
    %Counter
    subplot(2, 2, 3);
    x = [1:t];
    hold on;
    l1 = plot(x,organismCountMat(:,1),'DisplayName','Grass');
    l2 = plot(x,organismCountMat(:,2),'DisplayName','Antilopes');
    l3 = plot(x,organismCountMat(:,3),'DisplayName','Lions');
    set(l1,'Color',color_Grass);
    set(l2,'Color',color_Antilope);
    set(l3,'Color',color_Lion);
    legend(gca,'show');
    xlabel('Time');
    ylabel('Count');
    set(gca,'Color',[0,0,0]);
    set(legend,'Color',[0,0,0]);
    set(legend,'TextColor',[1,1,1]);
    hold off;
end

