% Problem 3.1

function []= LogExpMap()
% Define characteristic lines for plotting

c1 =  [ linspace(.1,1,50)'  0.1*ones(50,1) ]; 
c2 =  [ linspace(.1,1,50)'  0.55*ones(50,1) ];
c3 =  [ linspace(.1,1,50)'  1.0*ones(50,1) ];
c4 =  [ 0.1*ones(50,1) linspace(.1,1,50)' ];
c5 =  [ 0.55*ones(50,1) linspace(.1,1,50)' ];
c6 =  [ 1.0*ones(50,1) linspace(.1,1,50)' ];

% Plot the original body black
plot(c1(:,1),c1(:,2),'k:','Linewidth',2); hold on
plot(c2(:,1),c2(:,2),'k:','Linewidth',2);
plot(c3(:,1),c3(:,2),'k:','Linewidth',2);
plot(c4(:,1),c4(:,2),'k:','Linewidth',2);
plot(c5(:,1),c5(:,2),'k:','Linewidth',2);
plot(c6(:,1),c6(:,2),'k:','Linewidth',2);

% Set aspect ratio
axis equal

% Add motion to initial points
c1 = addmotion(c1);
c2 = addmotion(c2);
c3 = addmotion(c3);
c4 = addmotion(c4);
c5 = addmotion(c5);
c6 = addmotion(c6);

% Replot figure in gray
gray = [0.4, 0.4, 0.4];
plot(c1(:,1),c1(:,2),'-','Color',gray,'Linewidth',2);
plot(c2(:,1),c2(:,2),'-','Color',gray,'Linewidth',2);
plot(c3(:,1),c3(:,2),'-','Color',gray,'Linewidth',2);
plot(c4(:,1),c4(:,2),'-','Color',gray,'Linewidth',2);
plot(c5(:,1),c5(:,2),'-','Color',gray,'Linewidth',2);
plot(c6(:,1),c6(:,2),'-','Color',gray,'Linewidth',2);
axis equal
hold off


function [xy] = addmotion(c)
% function to add motion to array of (x,y) pairs 

 xy(:,1) =  c(:,1) + 0.2*log(1 + c(:,1) + c(:,2));
 xy(:,2) =  c(:,2) + 0.2*exp(c(:,1));
 

