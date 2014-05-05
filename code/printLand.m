function [] = printLand( mat, organismCountMat, t, deathCauseMat)
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
    title('Land');
    axis off;
   
    
    %DeathCause Age/Hunger Death
    %1: Hunger
    %2: Age
    %3: Eaten
    subplot(2, 2, 2);
    barPlot = bar(deathCauseMat,'stack');
    XLABELS = {'Grass','Antilope','Lion'};
    title('Death Causes');
    xlabel('Organism');
    ylabel('Total Deaths');
    set(gca,'XTickLabel',XLABELS)
    set(barPlot,{'FaceColor'},{[1,204/255,0];[0,153/255,1];[1,0,0]});
    legend({'Hunger', 'Age', 'Eaten'});
    set(gca,'Color',[0,0,0]);
    set(legend,'Color','none');
    set(legend,'TextColor',[1,1,1]);

    %DeathCause Age/Hunger Death
    %1: Hunger
    %2: Age
    %3: Eaten
    x = deathCauseMat./repmat(sum(deathCauseMat,2),1,3);
    x = x*100;
    subplot(2, 2, 4);
    barPlot = bar(x,'stack');
    XLABELS = {'Grass','Antilope','Lion'};
    title('Death Causes in Percentage');
    xlabel('Organism');
    ylabel('Percentage (%)');
    set(gca,'XTickLabel',XLABELS)
    set(barPlot,{'FaceColor'},{[1,204/255,0];[0,153/255,1];[1,0,0]});
    legend({'Hunger', 'Age', 'Eaten'});
    set(gca,'Color',[0,0,0]);
    set(legend,'Color','none');
    set(legend,'TextColor',[1,1,1]);
    
    %Counter
    subplot(2, 2, 3);
    x = [1:t];
    hold on;
    l1 = plot(x,organismCountMat(:,1),'DisplayName','Grass');
    l2 = plot(x,organismCountMat(:,2),'DisplayName','Antilopes');
    l3 = plot(x,organismCountMat(:,3),'DisplayName','Lions');
    
    title('Organism Count');
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

