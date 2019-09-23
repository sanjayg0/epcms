% Problem 3.3

function [] = kinematics03()

% Define some lines for plotting
dis = 500;
c1 = [ 0.1+0*ones(dis,1) linspace(0.1,1,dis)'];
c2 = [ .4*ones(dis,1) linspace(0.1,1,dis)'];
c3 = [ .7*ones(dis,1) linspace(0.1,1,dis)'];
c4 = [ 1.0*ones(dis,1) linspace(0.1,1,dis)'];

c5 =  [ linspace(0.1,1,dis)'   0.1+0*ones(dis,1) ];
c6 =  [ linspace(0.1,1,dis)'   0.4*ones(dis,1) ];
c7 =  [ linspace(0.1,1,dis)'   0.7*ones(dis,1) ];
c8 =  [ linspace(0.1,1,dis)'   1*ones(dis,1) ];

plot(c1(:,1),c1(:,2),'k:','Linewidth',2); hold on
plot(c2(:,1),c2(:,2),'k:','Linewidth',2); 
plot(c3(:,1),c3(:,2),'k:','Linewidth',2); 
plot(c4(:,1),c4(:,2),'k:','Linewidth',2); 
plot(c5(:,1),c5(:,2),'k:','Linewidth',2); 
plot(c6(:,1),c6(:,2),'k:','Linewidth',2); 
plot(c7(:,1),c7(:,2),'k:','Linewidth',2); 
plot(c8(:,1),c8(:,2),'k:','Linewidth',2); 

% Set aspect ratio
axis equal

% Get polar coordinates
rt1 = getrt53(c1); 
rt2 = getrt53(c2);
rt3 = getrt53(c3);
rt4 = getrt53(c4);
rt5 = getrt53(c5);
rt6 = getrt53(c6);
rt7 = getrt53(c7);
rt8 = getrt53(c8);

%Add motion to XY's and replot
xy1 = addm53(c1,rt1);
xy2 = addm53(c2,rt2);
xy3 = addm53(c3,rt3);
xy4 = addm53(c4,rt4);
xy5 = addm53(c5,rt5);
xy6 = addm53(c6,rt6);
xy7 = addm53(c7,rt7);
xy8 = addm53(c8,rt8);

% Replot figure in gray
gray = [0.4, 0.4, 0.4];
plot(xy1(:,1),xy1(:,2),'-','Color',gray,'Linewidth',2); 
plot(xy2(:,1),xy2(:,2),'-','Color',gray,'Linewidth',2); 
plot(xy3(:,1),xy3(:,2),'-','Color',gray,'Linewidth',2); 
plot(xy4(:,1),xy4(:,2),'-','Color',gray,'Linewidth',2); 
plot(xy5(:,1),xy5(:,2),'-','Color',gray,'Linewidth',2); 
plot(xy6(:,1),xy6(:,2),'-','Color',gray,'Linewidth',2);
plot(xy7(:,1),xy7(:,2),'-','Color',gray,'Linewidth',2);
plot(xy8(:,1),xy8(:,2),'-','Color',gray,'Linewidth',2); 
axis equal

function rt = getrt53(c)
% Get (r,theta) from (x,y)
 rt(:,1) = sqrt( c(:,1).^2 + c(:,2).^2 );
 rt(:,2) = atan2(c(:,2),c(:,1));

function [xy] = addm53(c,rt)
% Add motion
scale = 0.2; 

 xy(:,1) =  c(:,1) +( exp(c(:,1)).*cos(rt(:,2)) - ...
             log(1+c(:,1)+c(:,2)).*sin(rt(:,2)))*scale;
 xy(:,2) =  c(:,2) +( exp(c(:,1)).*sin(rt(:,2)) + ...
             log(1+c(:,1)+c(:,2)).*cos(rt(:,2)))*scale;
