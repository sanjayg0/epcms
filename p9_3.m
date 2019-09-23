% Problem 9.3

clear all; clc;

% Simulation parameters
edot = 1e-2; %strain rate
ef   = 0.25; %final strain
e0   = 0.00; %initial strain

% Material parameters for 316SS
Eyoung    = 200e9;  % Pa
Sy        = 250e6;  % Pa
K         = 1182e6; % Pa
eps_dot_0 = 1e-3;   % 1/seconds
n         = .47;    % strain hardening exponent
m         = 0.02;   % strain rate sensitivity parameter

% Al properties
% Eyoung    = 10e9; % Pa
% Sy        = 12e6; % Pa
% K         = 5e6;  % Pa
% eps_dot_0 = 1e-3; % 1/seconds
% n         = .8;   % strain hardening exponent
% m         = 0.2;  % strain rate sensitivity parameter


% Generate a strain profile
% Compute a time increment
dt = (Sy)/(Eyoung*edot*15);

% Create strain profile
e = linspace(e0,ef,ef/(edot*dt));

% Add an unloading cycle
% e = [e linspace(ef,e0,ef/(edot*dt))];

% Time Profile (for plotting)
time = linspace(0,ef/edot,length(e));


% To plot the strain time profile
% figure(1)
% plot(time,e,'o');
% xlabel('Time (s)')
% ylabel('Strain')
% fignum = fignum + 1;

% Initialize
stress(1)    = 0;  % set initial stress to zero
Y0           = Sy; % set the value of Y0
Y(1)         = Y0; % set the initial value of Y
e_p(1)       = 0;
eps_bar_p(1) = 0;  % set plastic strain to zero

np_vec = [];


% Begin computation
% Loop over the strain profile
for i = 1:length(e)-1
    
    % Compute the stress
    stress(i) = Eyoung*(e(i) - e_p(i)); 
    
    % Compute the direction of plastic flow
    np(i) = sign(stress(i));

    % Compute the hardening function
    Y(i) = Y0 + K*(eps_bar_p(i))^n;

    % Compute the magnitude of the 
    % equiv. tensile plastic strain rate
    eps_bar_dot(i) = eps_dot_0*( abs(stress(i))/Y(i))^(1/m);
    
    % Update the equiv. tensile plastic strain
    eps_bar_p(i+1) = eps_bar_p(i) + eps_bar_dot(i)*dt;
        
    % Update the plastic strain
    e_p(i+1) = e_p(i) + eps_bar_dot(i)*np(i)*dt;
    
    % Update the stress
    stress(i+1) = Eyoung*(e(i+1) - e_p(i+1));
    
    % Update the hardening function
    Y(i+1) = Y0 + K*(eps_bar_p(i+1))^n;

end

% Plot results
figure(2) % stress - strain
plot(e,stress/1E6,'LineWidth',2'); set(gca,'XMinorTick','On');
set(gca,'YMinorTick','On'); set(gca,'FontSize',16);
xlabel('Strain'); ylabel('Stress (MPa)'); xlim([e0 ef]);

% figure(3) % plastic strain - time
% plot(time,eps_bar_p,'LineWidth',2'); 
% set(gca,'XMinorTick','On');
% set(gca,'YMinorTick','On'); set(gca,'FontSize',16); 
% xlabel('Time');
% ylabel('$\bar{\epsilon}^p$','Interpreter','latex'); 
% xlim([0 max(time)]);

% figure(4) % resistance - time
% plot(time,Y/1e6,'LineWidth',2); set(gca,'XMinorTick','On');
% set(gca,'YMinorTick','On'); set(gca,'FontSize',16); 
% xlabel('Time');
% ylabel('Y (MPa)'); xlim([0 max(time)]);
