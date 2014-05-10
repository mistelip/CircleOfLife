function [] = LotkaVolterraThree()
X_START = 300;
WAVELENGTH = 200;
ENDTIME = 3*WAVELENGTH/(WAVELENGTH/50);
% timestep
dt=0.00006*WAVELENGTH;
% iterations
iter=333*ENDTIME;

% initialize vectors
x=zeros(iter,1); y=zeros(iter,1); z=zeros(iter,1); t=zeros(iter,1);
l = 0.05/WAVELENGTH;

x(1)=1*X_START; y(1)=0.1*X_START; z(1)=0.1*X_START; t(1)=0; % starting point

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

color_Lion = [1 0 0];
color_Antelope = [244/255, 164/255, 96/255];
color_Grass = [0 1 0];

plot(t,x,'color',color_Grass);
hold on;
plot(t,y,'color',color_Antelope);
plot(t,z,'color',color_Lion);
legend('grass','antilopes','lions');
end

