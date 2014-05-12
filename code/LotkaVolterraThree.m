function [] = LotkaVolterraThree()

clf;
color_Lion = [1 0 0];
color_Antelope = [244/255, 164/255, 96/255];
color_Grass = [0 1 0];
FONTSIZE = 15;

X_START = 300;
WAVELENGTH = 50;
ENDTIME = 100;
% timestep
dt=0.00006*WAVELENGTH;
% iterations
iter=333*ENDTIME;

% initialize vectors
x=zeros(iter,1); y=zeros(iter,1); z=zeros(iter,1); t=zeros(iter,1);
l = 0.05/WAVELENGTH;

x(1)=1*X_START; y(1)=0.1*X_START*0; z(1)=0.1*X_START; t(1)=0; % starting point

a=0.5*X_START*l; b=1*l; c=1*l; d=0.5*l; e=1*l; f=0.5*X_START*l; g=1*l;

for i=2:iter
    dx=a*x(i-1)- b*x(i-1)*y(i-1);
    dy=-c*y(i-1) + d*x(i-1)*y(i-1) - e*y(i-1)*z(i-1);
    dz=-f*z(i-1) + g*y(i-1)*z(i-1);
    x(i)=x(i-1)+dt*dx;
    y(i)=y(i-1)+dt*dy;
    z(i)=z(i-1)+dt*dz;
    t(i)=t(i-1)+dt;
end

%hold on;
semilogy(t,x,'LineWidth',2,'Color',color_Grass);
hold on;
semilogy(t,y,'LineWidth',2,'Color',color_Antelope);
semilogy(t,z,'LineWidth',2,'Color',color_Lion);
%Legend
legend('grass','antilopes','lions');
legend(gca,'show');
%set(legend,'Color',[0,0,0]);
%set(legend,'TextColor',[1,1,1]);
set(legend,'Location','NorthOutside');


%Axis
xlab = xlabel('Time');
ylab = ylabel('Quantity');
set(xlab,'FontSize',FONTSIZE);
set(ylab,'FontSize',FONTSIZE);
set(gca, 'XColor', 'w');
set(gca, 'YColor', 'w');

set(gca,'XColor',[0,0,0]);
set(gca,'YColor',[0,0,0]);
set(gcf,'Color',[1,1,1]);
set(gca,'FontSize',FONTSIZE);
grid on;
hold off;

end

