function [] = LotkaVolterraThree()
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
plot(x);
hold on;
plot(y,'r');
plot(z,'g');
legend('grass','antilopes','lions');
%plot3(x,y,z);
end

