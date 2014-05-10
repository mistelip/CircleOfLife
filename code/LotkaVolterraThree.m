function [] = LotkaVolterraThree()

clf;
color_Lion = [1 0 0];
color_Antelope = [244/255, 164/255, 96/255];
color_Grass = [0 1 0];
FONTSIZE = 15;

% timestep
dt=0.001;
% iterations
iter=10000;

% initialize vectors
x=zeros(iter,1); y=zeros(iter,1); z=zeros(iter,1); t=zeros(iter,1);
x(1)=.5; y(1)=1; z(1)=2; t(1)=0; % starting point

a=1; b=1; c=1; d=1; e=1; f=1; g=1;

for i=2:iter
    dx=a*x(i-1)- b*x(i-1)*y(i-1);
    dy=-c*y(i-1) + d*x(i-1)*y(i-1) - e*y(i-1)*z(i-1);
    dz=-f*z(i-1) + g*y(i-1)*z(i-1);
    x(i)=x(i-1)+dt*dx;
    y(i)=y(i-1)+dt*dy;
    z(i)=z(i-1)+dt*dz;
    t(i)=t(i-1)+dt;
end
hold on;
l1 = plot(x);
l2 = plot(y);
l3 = plot(z);
set(l1,'Color',color_Grass);
set(l2,'Color',color_Antelope);
set(l3,'Color',color_Lion);

%Legend
legend('grass','antilopes','lions');
legend(gca,'show');
set(legend,'Color',[0,0,0]);
set(legend,'TextColor',[1,1,1]);
set(legend,'Location','NorthOutside');


%Axis
xlab = xlabel('Time');
ylab = ylabel('Quantity');
set(xlab,'FontSize',FONTSIZE);
set(ylab,'FontSize',FONTSIZE);
set(gca, 'XColor', 'w');
set(gca, 'YColor', 'w');

set(gca,'Color',[0,0,0]);
set(gcf,'Color',[0,0,0]);
set(gca,'FontSize',FONTSIZE);
grid on;
hold off;

end

