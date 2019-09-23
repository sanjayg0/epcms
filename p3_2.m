% Problem 3.2

function []= annulusmap()
% Define some polar curves for plotting

c1 = [ 1*ones(300,1) linspace(0,2*pi,300)'];
c2 = [ 2*ones(300,1) linspace(0,2*pi,300)'];

c3 =  [ linspace(1,2,50)'         0*ones(50,1) ];
c4 =  [ linspace(1,2,50)'  (1*pi/4)*ones(50,1) ];
c5 =  [ linspace(1,2,50)'  (2*pi/4)*ones(50,1) ];
c6 =  [ linspace(1,2,50)'  (3*pi/4)*ones(50,1) ];
c7 =  [ linspace(1,2,50)'  (4*pi/4)*ones(50,1) ];
c8 =  [ linspace(1,2,50)'  (5*pi/4)*ones(50,1) ];
c9 =  [ linspace(1,2,50)'  (6*pi/4)*ones(50,1) ];
c10 = [ linspace(1,2,50)'  (7*pi/4)*ones(50,1) ];
c11 = [ linspace(1,2,50)'  (8*pi/4)*ones(50,1) ];

% Compute the X,Y locations of the points
XY1 = getxy(c1);
XY2 = getxy(c2);
XY3 = getxy(c3);
XY4 = getxy(c4);
XY5 = getxy(c5);
XY6 = getxy(c6);
XY7 = getxy(c7);
XY8 = getxy(c8);
XY9 = getxy(c9);
XY10 = getxy(c10);
XY11 = getxy(c11);

plot(XY1(:,1),XY1(:,2),'k-','LineWidth',2); hold on
plot(XY2(:,1),XY2(:,2),'k:','LineWidth',2); 
plot(XY3(:,1),XY3(:,2),'k-','LineWidth',2); 
plot(XY4(:,1),XY4(:,2),'k-.','LineWidth',2); 
plot(XY5(:,1),XY5(:,2),'k:','LineWidth',2); 
plot(XY6(:,1),XY6(:,2),'k--','LineWidth',2);
plot(XY7(:,1),XY7(:,2),'k-','LineWidth',2);
plot(XY8(:,1),XY8(:,2),'k-.','LineWidth',2); 
plot(XY9(:,1),XY9(:,2),'k:','LineWidth',2); 
plot(XY10(:,1),XY10(:,2),'k--','LineWidth',2); 
plot(XY11(:,1),XY11(:,2),'k-','LineWidth',2);

% Set aspect ratio
axis equal

% Add motion to XY's and replot
xy1 = addmotion(XY1,c1);
xy2 = addmotion(XY2,c2);
xy3 = addmotion(XY3,c3);
xy4 = addmotion(XY4,c4);
xy5 = addmotion(XY5,c5);
xy6 = addmotion(XY6,c6);
xy7 = addmotion(XY7,c7);
xy8 = addmotion(XY8,c8);
xy9 = addmotion(XY9,c9);
xy10 = addmotion(XY10,c10);
xy11 = addmotion(XY11,c11);

% Replot on new figure
figure
plot(xy1(:,1),xy1(:,2),'k-','LineWidth',2); hold on
plot(xy2(:,1),xy2(:,2),'k:','LineWidth',2); 
plot(xy3(:,1),xy3(:,2),'k-','LineWidth',2); 
plot(xy4(:,1),xy4(:,2),'k-.','LineWidth',2); 
plot(xy5(:,1),xy5(:,2),'k:','LineWidth',2); 
plot(xy6(:,1),xy6(:,2),'k--','LineWidth',2);
plot(xy7(:,1),xy7(:,2),'k-','LineWidth',2);
plot(xy8(:,1),xy8(:,2),'k-.','LineWidth',2); 
plot(xy9(:,1),xy9(:,2),'k:','LineWidth',2); 
plot(xy10(:,1),xy10(:,2),'k--','LineWidth',2); 
plot(xy11(:,1),xy11(:,2),'k-','LineWidth',2);

axis equal

function [xy] = getxy(c)
% Get (x,y) from polar (r,theta)

for i=1:length(c)
 xy(i,1) = c(i,1)*cos( c(i,2) );
 xy(i,2) = c(i,1)*sin( c(i,2) );
end

function [xy] = addmotion(XY,c)
% Add motion

 xy(:,1) =  XY(:,1) +((c(:,1) - 1).^2.*cos(3*c(:,2)).*cos(c(:,2)) ...
         -  (c(:,1) - 1).^3.*sin(c(:,2)) )*0.4;

 xy(:,2) =  XY(:,2) +((c(:,1) - 1).^2.*cos(3*c(:,2)).*sin(c(:,2)) ...
         +  (c(:,1) - 1).^3.*cos(c(:,2)) )*0.4;
