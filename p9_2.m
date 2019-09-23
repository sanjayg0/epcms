% Problem 9.2

clear; clc;

% Set up material properties
E   = 200e9;     % Young Modulus N/m^2
S_0 = 287e6;     % Initial Yield N/m^2
H_0 = 2000e6;    % Hardening N/m^2
S_s = 995e6;     % Saturation Yield N/m^2
r   = 0.6255;    % Hardening Exponent [-]
H   = @(x) H_0*(1 - x/S_s)^r; % Hardening rate

% Select model type (true for linear, false nonlinear)
linear = false;

eps_f = 0.01;  % Max Strain
dot_e = 0.001; % Strain Rate

% Timestep size param 0.1, 0.5, 1, 2, 5
beta  = 0.1;         

d_eps = beta*(S_0/E);    % Strain step
dt    = d_eps/dot_e; % Time step

% Select number of cycles (0.25 for monotonic)
cycles = 5;
steps = floor(4*cycles*(eps_f/d_eps));

% Initialize/allocate data arrays
eps    = zeros(1,steps+1);  % Strains
eps_p  = zeros(1,steps+1);  % Plastic Strains
sigma  = zeros(1,steps+1);  % Stresses
S      = zeros(1,steps+1);  % Flow Stress
S(1)   = S_0;
branch = 1;
tol    = 1e-10;

for i=2:(steps+1) 
    % Compute strain
    eps(i) = eps(i-1) + branch*d_eps;
    if (eps(i) > eps_f+tol)
        branch = -1;
        eps(i) = eps(i-1) + branch*d_eps;
    elseif (eps(i) < -eps_f-tol)
        branch = 1;
        eps(i) = eps(i-1) + branch*d_eps;
    end
    
    % Compute trial state
    sigma_tr = sigma(i-1)+E*branch*d_eps;
    eps_p_tr = eps_p(i-1);
    S_tr     = S(i-1);
    f_tr     = abs(sigma_tr)-S_tr;
    
    % Check trial state
    if (f_tr <= 0)
        sigma(i) = sigma_tr;
        eps_p(i) = eps_p_tr;
        S(i)     = S_tr;
    else
        % Correct trial state
        if linear
            d_eps_p = f_tr/(E+H_0);
            S(i)    = S(i-1) + H_0*d_eps_p;
        else
            g       = @(x) x - S_tr - H(x)*...
                  (abs(sigma_tr)-x)/E;
            S(i)    = fzero(g,[S_tr S_s]);
            d_eps_p = (abs(sigma_tr)-S(i))/E;
        end
        eps_p(i) = eps_p(i-1)+d_eps_p*sign(sigma_tr);
        sigma(i) = E*(eps(i)-eps_p(i));
    end
end

plot(eps,sigma/1e9,'LineWidth',2); 
xlabel('Strain','FontSize',16);
ylabel('Stress (GPa)','FontSize',16);
set(gca,'XMinorTick','On','YMinorTick','On',...
  'FontSize',16);

