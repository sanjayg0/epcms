% Problem 11.15

% Load the data
load epoxyEr.txt;

% Re-label the data
data = epoxyEr;

% Subract out E_re
Einf      = data(end,2);
data(:,2) = data(:,2) - Einf;

% Shift the time
data(:,1) = data(:,1) - data(1,1);
n         = size(data,1);

% Start with 10 relaxation times over the 15 decades
sdecade = -10;
fdecade =  5;
tau     = logspace(sdecade,fdecade,10);

E = Efit(tau,data,Einf)

% Examine E showing the need to drop the last element
% re-run with one fewer relaxation time
E = Efit(tau(1:end-1),data,Einf)


function [E] = Efit(tau,data,Einf)
 N = length(tau);

 % Set up the least square-fit equations
 for j = 1:N
 v(:,j) = exp(-data(:,1)./tau(j));
 end

 % Normal matrix and right-hand side
 M = v'*v;
 F = v'*data(:,2);

 % Solve for the Ek values
 E = M\F;

 % Plot
 figure
 f=loglog(data(:,1),data(:,2)+Einf,'ks' ,data(:,1), v*E+Einf);
 ylabel('$E_r(t)$ (MPa)','FontSize',20,'Interpreter','latex');
 xlabel('Time (min)','FontSize',20,'Interpreter','latex');
 title( sprintf('Number of relaxation times = %d',N) , ...
     'FontSize', 20,'Interpreter','latex');
 set(f,'LineWidth',1.5)
end
