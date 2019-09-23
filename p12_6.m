% Problem 12.6

zeta= linspace(0.005,0.996, 50);

N=length(zeta);
beta=zeros(N,1);
beta2=zeros(N,1);

for i =1:N      
    F=@(beta) coth(beta)-(1/beta)-zeta(i);
    % Langevin inverse
    beta(i) = fzero(F,1);  
    % Pade approx                         
    beta2(i) = zeta(i)*(3-zeta(i)^2)/(1-zeta(i)^2);  
end
 
figure 
plot(zeta,beta,'k-',zeta,beta2,'k x','LineWidth',2);

xlabel('$\zeta$','FontSize',20,'Interpreter','latex');
ylabel('$\beta=\mathcal{L}^{-1}(\zeta)$',...
  'FontSize',20,'Interpreter','latex');

legend_handle = legend('Langevin inverse',...
  'Pade approximation');
set(legend_handle,'FontSize',20,'Interpreter','latex',...
    'Location','NorthWest')

