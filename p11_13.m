% Problem 11.13

% Material properties  
E_0   = 10; %MPa
E_1   = 20; %MPa
E_2   = 15; %MPa
E_3   = 5;  %Mpa

tau_1 = 0.5; %s
tau_2 = 0.1; %s
tau_3 = 1.0; %s

tot_time  = 25.;          % total time
N         = 1000;         % number of increments
dt        = tot_time/N;   % increment in time
time      = zeros(N,1);   % time
epsilon   = zeros(N,1);   % strain 
sigma     = zeros(N,1);   % stress 
h1        = zeros(N,1);   % contribution to stress  
h2        = zeros(N,1);   % contribution to stress  
h3        = zeros(N,1);   % contribution to stress  
A         = 1.E-2;

for i=2:N
    time(i) = time(i-1)+dt;
    if time(i) < 10. 
       epsilon(i) =  A*time(i)*sin(time(i));
    elseif (time(i)>= 10. && time(i) <20.0)  
       epsilon(i)  = A*1.d0;
    else
       epsilon(i) = A*0.d0;
    end 
    
    de = epsilon(i) - epsilon(i-1);
    h1(i) = exp(-dt/tau_1)*h1(i-1) ...
      + E_1*(tau_1/dt)*(1- exp(-dt/tau_1))*de;
    h2(i) = exp(-dt/tau_2)*h2(i-1) ...
      + E_2*(tau_2/dt)*(1- exp(-dt/tau_2))*de;
    h3(i) = exp(-dt/tau_3)*h3(i-1) ...
      + E_3*(tau_3/dt)*(1- exp(-dt/tau_3))*de;    
    sigma(i) = E_0*epsilon(i) + h1(i) + h2(i) + h3(i);
end  
   
figure % new figure
plot(time,epsilon,'k-.','LineWidth',2);
xlabel('$t$ (s)','FontSize',20,'Interpreter','latex');
ylabel('$\epsilon$','FontSize',20,'Interpreter','latex'); 

figure % new figure
plot(time,sigma,'k-','LineWidth',2);
xlabel('$t$ (s)','FontSize',20,'Interpreter','latex'); 
ylabel('$\sigma$ (MPa)','FontSize',20,...
  'Interpreter','latex'); 

