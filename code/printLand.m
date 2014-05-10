function [] = printLand( mat, organismCountMat, t, deathCauseMat)
%PRINTLAND Summary of this function goes here
%   Detailed explanation goes here

    color_Lion = [1 0 0];
    color_Antelope = [244/255, 164/255, 96/255];
    color_Grass = [0 1 0];
    color_Nothing = [0 0 0];
    FONTSIZE = 15;
    clf;                                 % Clear figure
    

    %Land-------------------------------------------------
    subplot(2, 2, 1);
    imagesc(mat, [0 3]);                   % Display grid                
    colormap([color_Nothing; color_Grass; color_Antelope; color_Lion]);
    set(gca,'YTickLabel',[]);
    set(gca,'XTickLabel',[]);
    axis on;
    
    %Title
    titl = title('Land','fontWeight','bold');
    set(titl,'FontSize',FONTSIZE);
    set(titl,'Color',[1,1,1]);
    
    %Axis
    set(gca, 'XColor', 'w');
    set(gca, 'YColor', 'w');
    
    %Legend
    set(legend,'TextColor',[1,1,1]);
    set(gca,'FontSize',FONTSIZE);
    
   
    
    %DeathCause Age/Hunger Death-----------------------
    %1: Hunger
    %2: Age
    %3: Eaten
    subplot(2, 2, 2);
    barPlot = bar(deathCauseMat,'stack');
    XLABELS = {'Grass','Antelope','Lion'};
    set(gca,'Color',[0 0 0]);
    set(gca,'FontSize',FONTSIZE);
    set(barPlot,{'FaceColor'},{[1,204/255,0];[0,153/255,1];[1,0,0]});
    grid on;
    
    %Title
    titl = title('Death Causes','fontWeight','bold');
    set(titl,'FontSize',FONTSIZE);
    set(titl,'Color',[1,1,1]);

    
    %Axis
    xlab = xlabel('(Organism)');
    ylab = ylabel('Total Deaths');
    set(xlab,'FontSize',FONTSIZE);
    set(ylab,'FontSize',FONTSIZE);
    set(gca, 'XColor', 'w');
    set(gca, 'YColor', 'w');
    set(gca,'XTickLabel',XLABELS);
    set(gca,'FontSize',FONTSIZE);
    
    %Legend
    legend({'Hunger', 'Age', 'Eaten'});
    set(legend,'Color',[0,0,0]);
    set(legend,'TextColor',[1,1,1]);
    set(legend,'Location','EastOutside');

    %DeathCause (%) Age/Hunger Death----------------------
    %1: Hunger
    %2: Age
    %3: Eaten
    x = deathCauseMat./repmat(sum(deathCauseMat,2),1,3);
    x = x*100;
    subplot(2, 2, 4);
    barPlot = bar(x,'stack');
    XLABELS = {'Grass','Antelope','Lion'};
    set(gca,'Color',[0,0,0]);
    set(gca,'FontSize',FONTSIZE);
    set(barPlot,{'FaceColor'},{[1,204/255,0];[0,153/255,1];[1,0,0]});
    ylim([0 100]);
    grid on;
    
    %Title
    titl = title('Death Causes in Percentage','fontWeight','bold');
    set(titl,'FontSize',FONTSIZE);
    set(titl,'Color',[1,1,1]);
    
    %Axis
    xlab =xlabel('(Organism)');
    ylab =ylabel('Deaths in Percentage (%)');
    set(xlab,'FontSize',FONTSIZE);
    set(ylab,'FontSize',FONTSIZE);
    set(gca, 'XColor', 'w');
    set(gca, 'YColor', 'w');
    set(gca,'XTickLabel',XLABELS)
    
    %Legend
    legend({'Hunger', 'Age', 'Eaten'});
    set(legend,'Color',[0,0,0]);
    set(legend,'TextColor',[1,1,1]);
    set(legend,'Location','EastOutside');
    
    %Counter-------------------------------
    subplot(2, 2, 3);
    x = 1:t;
    hold on;
    l1 = plot(x,organismCountMat(:,1),'DisplayName','Grass');
    l2 = plot(x,organismCountMat(:,2),'DisplayName','Antelopes');
    l3 = plot(x,organismCountMat(:,3),'DisplayName','Lions');
    set(l1,'Color',color_Grass);
    set(l2,'Color',color_Antelope);
    set(l3,'Color',color_Lion);
    set(gca,'Color',[0,0,0]);
    set(gca,'FontSize',FONTSIZE);
    if (t < 200)
        xlim([0 200]);
    else
        xlim('auto');
    end
    grid on;
    
    %Title
    titl =title('Organism Count','fontWeight','bold');
    set(titl,'FontSize',FONTSIZE);
    set(titl,'Color',[1,1,1]);
    
    %Axis
    xlab = xlabel('Time');
    ylab = ylabel('Count');
    set(xlab,'FontSize',FONTSIZE);
    set(ylab,'FontSize',FONTSIZE);
    set(gca, 'XColor', 'w');
    set(gca, 'YColor', 'w');
    
    %Legend
    legend(gca,'show');
    set(legend,'Color',[0,0,0]);
    set(legend,'TextColor',[1,1,1]);
    set(legend,'Location','NorthOutside');
    
    hold off;
end

